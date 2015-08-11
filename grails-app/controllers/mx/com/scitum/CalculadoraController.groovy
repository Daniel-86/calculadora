package mx.com.scitum

import grails.converters.JSON
import groovy.util.logging.Log4j

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import mx.com.scitum.helpers.DependenciesList

@Log4j
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
        def item = request.JSON.item
        String descripcion = request.JSON.descripcion
        String customId = request.JSON.customId
        String domainType = request.JSON.domainType
        def newInstance
        def children
        if(!item) {
            newInstance = new Categoria(descripcion: descripcion, customId: customId.replaceAll(' ', '_'))
        }
        else {
            def newConcept
            newInstance = Item.get(item.id)

            if(!domainType || domainType == 'concepto') {
                newConcept = new Concepto(
                        descripcion: descripcion,
                        customId: customId.replaceAll(' ', '_'),
                        costo: 0)
                newInstance.addToConceptos(newConcept)
            }
            else if(domainType == 'componente') {
                newConcept = new ConceptoEspecial(
                        descripcion: descripcion,
                        customId: customId.replaceAll(' ', '_'))
                newInstance.addToComponentes(newConcept)
            }
//            if(item.nodeType == 'ROOT')
//                newInstance = Categoria.get(item.id)
//            children = newInstance.componentes + newInstance.conceptos
//            println "children $children"
        }
        newInstance?.save(flush: true, failOnError: true)
        if(!item)
            children = Categoria.list(fetch: [conceptos: 'eager', componentes: 'eager'])
        else {
            children = (newInstance.componentes ?: []) + (newInstance.conceptos ?: [])
//            if(children.size() > 0) children = children[0]
        }
        render ([categories: Categoria.list(fetch:[conceptos: "eager", componentes: 'eager']), 'children': children,
                 newItem: newInstance
        ] as
                JSON)
    }


    def deleteItem() {
        def item = request.JSON.item
        def parent = request.JSON.parent
        log.debug "ITEM $item"
        log.debug "PARENT $parent"

        Item itemInstance = unmarshallerService.getConcreteItem(item)
        Item parentInstance = unmarshallerService.getConcreteItem(parent)
        if(!itemInstance || (itemInstance && !itemInstance instanceof Categoria && !parentInstance)) {
            respond status: OK
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



    def bestMatch = { lista, test->
        lista.inject([:]) { found, current ->
            def matched = current.data.intersect(test)
            print "\n\n${current.data} \tC\t $test \t=\t $matched\t\tmissing:${current.data - matched}\textra:${test - matched}"
            def matchedVals = matched?.size()
            println "\t\t*$matchedVals*"
            if (matchedVals == current.data.size()) {
                found = current
                found.matched = matched
                found.missing = found.data - matched
                found.extra = test - matched
            } else if (matchedVals > found.size()) {
                found = current
                found.matched = matched
                found.missing = found.data - matched
                found.extra = test - matched
            }
            println "\tFOUND $found"
            return found
        }
    }




    def calcular() {
        def requestData = params.postData
//        println "requestData $requestData"
//        println "params $params"
//        println "postData ${request.JSON.postData}"

        def tree = request.JSON.postData



//        def sizesMap = [:]
//        tree.each { rootItem->
//            if(rootItem.value instanceof Collection) {
//                sizesMap."${rootItem.key}" = rootItem.value
//                rootItem.value.each {
//
//                }
//            }
//        }

        List dependenciesList = []
        List dependenciesName = []
        Map ammountMap = [:].withDefault {0}
        tree.each { categor->
            categor.each { catego ->
                dependenciesName << catego.key
                if (catego.key == 'tipo_de_cliente') {
                    dependenciesName << catego.value
                } else if (catego.key == 'ingenieria_en_sitio') {
                    dependenciesName += catego.value.keySet() as List
                    ammountMap << catego.value
                } else if(catego.key == 'tecnologia') {
                    catego.value.each { techh->
                        techh.each { tech ->
                            dependenciesName << tech.key
                            tech.value.each { depsPerDevice ->
                                dependenciesName += depsPerDevice
                                depsPerDevice.each {ammountMap[it]++}
                            }
                            ammountMap[tech.key] = tech.value.size()
                        }
                    }
                }
            }
        }

        dependenciesList = dependenciesName.collect {Item.findByCustomId(it)}

        List<Regla> allRules = Regla.list()
        def bestMatch = null
        use(DependenciesList) {
            bestMatch = allRules.bestTicketMatch(dependenciesList)
        }
        List factores = allRules.findAll {
            if(!(it instanceof Factor))
                return false
            if(!dependenciesList.containsAll(it.dependencies))
                return false
            def deps = it.dependencyDetail
            deps.each {
                if(it.lowerLimit) {
                    def itlow = it.lowerLimit
                    def amo = ammountMap[it.item.customId]
                    if(it.lowerLimit > ammountMap[it.item.customId]) {return false}
                }
                if(it.upperLimit) {
                    if(it.upperLimit < ammountMap[it.item.customId]) return false
                }
            }

            def isWrong = deps.any {
                if(it.lowerLimit)
                    if(it.lowerLimit > ammountMap[it.item.customId]) {return true}
                if(it.upperLimit)
                    if(it.upperLimit < ammountMap[it.item.customId]) return true
                return false
            }

            def algun ='debug'

            return !isWrong
        }

        def modifiers = factores.collect {fac->
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
                modDataL << modData
            }
            return modDataL
        }
        def baseData = [:]
        baseData.nombre = bestMatch?.nombre
        baseData.descripcion = bestMatch?.descripcion
        baseData.acs = bestMatch?.acs
        baseData.rq = bestMatch?.rq
        baseData.es = bestMatch?.es
        baseData.cc = bestMatch?.cc
        def data = [best: baseData, modifiers: modifiers]
//        println "${data as JSON}"

        render(data as JSON)


        /**
         * Esto debe servir para obtener los tickets y los factores
         * **** considerar la posibilidad de siempre obtener un registro, puede ser el que tenga mayor número de
         * concidencias
         * **** considerar posibilidad de reportar las dependencias faltantes para coincidir completamente con la regla
         */
    }
}
