package mx.com.scitum

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.util.logging.Log4j

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import mx.com.scitum.helpers.DependenciesList

@Log4j
//@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class CalculadoraController {

    def springSecurityService
    def unmarshallerService
//    def log = Logger.getLogger()

    def index() {
        [categories: [
                 [descripcion: 'Tipo de cliente',
                  multiple: false,
                  items: [
                          [descripcion: 'Gobierno', costo: 1],
                          [descripcion: 'Privado', costo: 2],
                          [descripcion: 'Financiero', costo: 3]]],
                 [descripcion: 'Arquitectura',
                  multiple: false,
                  items: [
                          [descripcion: 'Centralizado', costo: 1],
                          [descripcion: 'Distribuido', costo: 2]
                          ]],
                 [descripcion: 'Ingeniería en sitio',
                  multiple: false,
                  items: [
                          [descripcion: 'Sí', costo: 1],
                          [descripcion: 'No', costo: 2]]],
                 [descripcion: 'Tecnología',
                  multiple: true,
                  items: [
                          [descripcion: 'Firewall', costo: 1],
                          [descripcion: 'IPS', costo: 2],
                          [descripcion: 'Filtrado web', costo: 3]]]
                 ]
        ]
        def user = springSecurityService.getPrincipal()
        def asdf = ""
    }

    def addItem() {
        if(request.method == 'OPTIONS') {respond OK; return;}
        def newItemData = request.JSON
        def newInstance = null;
        def children
        if(!newItemData.parent) {
            newInstance = new Categoria(descripcion: newItemData.descripcion,
                    nombre: newItemData.nombre.replaceAll(' ', '_'),
                    customId: newItemData.nombre)
            newInstance.setNombre(newItemData.nombre)
            newInstance.setCustomId(newItemData.nombre)
            newInstance?.save(flush: true, failOnError: true)
        }
        else {
            def parent
            parent = unmarshallerService.getConcreteItem(newItemData.parent)

            if(!newItemData.domainType || newItemData.domainType == 'concepto') {
                newInstance = new Concepto(
                        descripcion: newItemData.descripcion,
                        nombre: newItemData.nombre,
                        customId: newItemData.nombre,
                        costo: 0)
                newInstance.setNombre(newItemData.nombre)
                newInstance.setCustomId(newItemData.nombre)
                if(parent instanceof Categoria)
                    parent.addToConceptos(newInstance)
                else if(parent instanceof ConceptoEspecial)
                    parent.addToConceptosE(newInstance)
            }
            else if(newItemData.domainType == 'componente') {
                newInstance = new ConceptoEspecial(
                        descripcion: newItemData.descripcion,
                        nombre: newItemData.nombre,
                        customId: newItemData.nombre)
                newInstance.setNombre(newItemData.nombre)
                newInstance.setCustomId(newItemData.nombre)
                if(parent instanceof Categoria)
                    parent.addToComponentes(newInstance)
            }
            parent.save(flush: true, failOnError: true)
        }
        if(!newItemData.parent)
            children = Categoria.list(fetch: [conceptos: 'eager', componentes: 'eager'])
        else {
            if(newInstance instanceof Categoria) {
                children =
                        (newInstance.componentes?: []) + (newInstance.componentes)
            }
            else if(newInstance instanceof ConceptoEspecial) {
                children =
                        (newInstance.conceptosE?: [])
            }
            else if(newInstance instanceof Concepto || newInstance instanceof Propiedad) {
                children = []
            }
//            children = (newInstance instanceof Categoria? newInstance.componentes: [])
//            + (newInstance instanceof ConceptoEspecial? newInstance.conceptosE: [])
//            + (newInstance.conceptos?: [])
//            if(children.size() > 0) children = children[0]
        }
        def allCategos = Categoria.list(fetch:[conceptos: "eager", componentes: 'eager'])
        render ([categories: Categoria.list(fetch:[conceptos: "eager", componentes: 'eager']),
                 'children': children,
                 newItem: newInstance] as JSON)
    }


    def deleteItem() {
        if(request.method == 'OPTIONS') {respond OK; return;}
        def item = request.JSON.item
        def parent = request.JSON.parent
        log.debug "ITEM $item"
        log.debug "PARENT $parent"

        Item itemInstance = unmarshallerService.getConcreteItem(item)
        Item parentInstance = unmarshallerService.getConcreteItem(parent)
        if(!itemInstance || (itemInstance && !itemInstance instanceof Categoria && !parentInstance)) {
            respond status: 500
            return
        }
        if(unmarshallerService.removeDependency(parentInstance, itemInstance)) {
            respond status: OK
        }
        else
            respond status: 500
    }

    def list() {
        List categories = Categoria.list(fetch:[conceptos: "eager", componentes: 'eager']);
//        JSON.use('deep') {
//            render categories as JSON
//        }
        render ([categories: categories, currentCatego: [techSelected: [currentItem: null, propiedades: [], arr: []]]]
                as JSON)
    }

    def cms() {

    }

    private def inspectTree(Collection collection) {
        def sizesMap = [:]
        collection.each { rootItem->
            if(rootItem.value instanceof Collection) {
                sizesMap."${rootItem.key}" = rootItem.value
            }
        }
    }




    def calcular() {

        def tree = request.JSON.postData

        List requiredDeps = []
        List extraDeps = []
        Map counts = [:]
        def customCounts = []
        Map servicesDeps = [:]
        def auxServiceDep = [:].withDefault {[]}
        tree.each { category->
            if(category.key == 'tipo_de_cliente') {
                requiredDeps << Item.findByCustomId(category.value.customId)
            }
            else if(category.key == 'ingenieria_en_sitio') {
                category.value.each { componente->
                    extraDeps << Item.findByCustomId(componente.key)
                    componente.value.each { property->
                        if(property.key != componente.key) {
                            requiredDeps << Item.findByCustomId(property.key)
                            if(property.key.contains('cantidad')) {
                                counts[property.key] = property.value
                            }
                        }
                    }
                }
            }
            else if(category.key == 'tecnologia') {
                category.value.each {componente->
                    componente.value.devices.eachWithIndex { device, idx->
                        servicesDeps[componente.key+'-'+idx] = device.selection.collect {Item.findByCustomId(it)}
                        customCounts << device.selection.collectEntries {[(it): device.count]}
                        auxServiceDep[componente.key] << servicesDeps[componente.key+'-'+idx]
                        counts[componente.key+'-'+idx] = device.count
                        if(!counts[componente.key]) {
                            counts[componente.key] = 0
                        }
                        counts[componente.key]++
                    }
                }
            }
        }

//        def countData

        List<Regla> allRules = Regla.list()
        def servicesMatch = []
        def rowsData
        def resultData = []
        def baseArrays = auxServiceDep.values()
        def combinations = GroovyCollections.combinations(baseArrays)
        combinations*.flatten().eachWithIndex { deviceDeps, idx->
            def currentRow = combinations[idx]
            def currentCounts = currentRow.collectEntries { partialDeps->
                customCounts.find {partialDeps*.customId.containsAll(it.keySet())}
            }
            currentCounts += counts
//            currentCounts = currentCounts.flatten()
            rowsData = [:]
            def bestMatchData = null
            def rowDependencies = requiredDeps+deviceDeps
            use(DependenciesList) {
                bestMatchData = allRules.bestTicketMatch(rowDependencies)
            }
            if(bestMatchData?.matched) {
                def bestMatch = bestMatchData.current
                def baseData = [:]
                baseData.nombre = bestMatch?.nombre
                baseData.descripcion = bestMatch?.descripcion
                baseData.acs = bestMatch?.acs
                baseData.rq = bestMatch?.rq
                baseData.es = bestMatch?.es
                baseData.cc = bestMatch?.cc
                baseData.best = bestMatchData
                servicesMatch << baseData
                rowsData.ticket = baseData
            }

            def factores = allRules.findAll {
                if(!(it instanceof Factor))
                    return false
                if(!rowDependencies.containsAll(it.dependencies))
                    return false
                def deps = it.dependencyDetail
                deps.each {
                    if(it.lowerLimit) {
                        def itlow = it.lowerLimit
                        def amo = currentCounts[it.item.customId]
                        if(it.lowerLimit > currentCounts[it.item.customId]) {return false}
                    }
                    if(it.upperLimit) {
                        if(it.upperLimit < currentCounts[it.item.customId]) return false
                    }
                }

                def isWrong = deps.any {
                    if(it.lowerLimit)
                        if(it.lowerLimit > currentCounts[it.item.customId]) {return true}


                    if(it.upperLimit)
                        if(it.upperLimit < currentCounts[it.item.customId]) return true
                    return false
                }

                def algun ='debug'

                return !isWrong
            }

            rowsData.factores = factores?.collect {fac->
                def modDataL = []
                def deps = fac.dependencyDetail
                deps.each {
                    def modData = [:]
                    modData.lowerLimit = it.lowerLimit
                    modData.upperLimit = it.upperLimit
                    modData.step = it.step
                    modData.factor = it.rule.factor
                    modData.nombre = it.rule.nombre
                    modData.descripcion = it.rule.descripcion
                    modData.customId = it.item.customId
                    modData.target = it.rule.target*.toString()
                    modDataL << modData
                }
                return modDataL
            }
            rowsData.factores = rowsData.factores.flatten()
            rowsData.counts = currentCounts

            resultData << rowsData
        }
        def abas = 2


        render ([results: resultData, counts: counts] as JSON)


        /**
         * Esto debe servir para obtener los tickets y los factores
         * **** considerar la posibilidad de siempre obtener un registro, puede ser el que tenga mayor número de
         * concidencias
         * **** considerar posibilidad de reportar las dependencias faltantes para coincidir completamente con la regla
         */
    }
}
