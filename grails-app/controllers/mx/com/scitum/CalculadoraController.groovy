package mx.com.scitum

import grails.converters.JSON
import mx.com.scitum.helpers.DependenciesList

class CalculadoraController {

    def springSecurityService

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
        def newInstance
        def itemType
        def children
        if(!item) {
            newInstance = new Categoria(descripcion: descripcion, customId: descripcion.replaceAll(' ', '_'))
        }
        else {
            def newConcept = new Concepto(descripcion: descripcion, customId: descripcion.replaceAll(' ', '_'),
                    costo: 0)
            if(item.nodeType == 'ROOT')
                newInstance = Categoria.get(item.id)
            newInstance.addToConceptos(newConcept)
//            children = newInstance.componentes + newInstance.conceptos
//            println "children $children"
        }
        newInstance?.save(flush: true, failOnError: true)
        itemType = newInstance?.nodeType
        println "ITEM $item"
        println "DESC $descripcion"
        if(!item)
            children = Categoria.list(fetch: [conceptos: 'eager', componentes: 'eager'])
        else {
            children = (newInstance.componentes ?: []) + (newInstance.conceptos ?: [])
            if(children.size() > 0) children = children[0]
        }
//        println "children base ${children}\n\t${children[0].id} ${children[0].descripcion}  ${children[0].costo}"
        println "children ${children as JSON}"
        render ([categories: Categoria.list(fetch:[conceptos: "eager", componentes: 'eager']), 'children': children] as
                JSON)
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
        println "postData ${request.JSON.postData}"

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
        tree.each { categor->
            categor.each { catego ->
                dependenciesName << catego.key
                if (catego.key == 'tipo_de_cliente') {
                    dependenciesName << catego.value
                } else if (catego.key == 'ingenieria_en_sitio') {
                    dependenciesName += catego.value.keySet() as List
                } else if(catego.key == 'tecnologia') {
                    catego.value.each { techh->
                        techh.each { tech ->
                            dependenciesName << tech.key
                            tech.value.each { depsPerDevice ->
                                dependenciesName += depsPerDevice
                            }
                        }
                    }
                }
            }
        }

        dependenciesList = dependenciesName.collect {Item.findByCustomId(it)}

        List allRules = Regla.list()
        def bestMatch
        use(DependenciesList) {
            bestMatch = allRules.bestTicketMatch(dependenciesList)
        }


//        dependenciesList.each { depItem->
//
//        }





//        List.metaClass.findBestMatch = { List list->
//
//        }

        /**
         * Esto debe servir para obtener los tickets y los factores
         * **** considerar la posibilidad de siempre obtener un registro, puede ser el que tenga mayor número de
         * concidencias
         * **** considerar posibilidad de reportar las dependencias faltantes para coincidir completamente con la regla
         */
//        matchedRules = allRules.findAll {rule->
//            temptativeRules = dependenciesList.findBestMatch(rule.dependencies)
//            subconditions = rule.dependencies.findAll {it.lowerLimit}
//            return temptativeRules.findAll {it.matchesAny{subconditions*.rule}}
//        }






        String tipocli
        String sitio
        String volumetria
        List techs = []
        Map recursos = [:]
        def sitioDetail = []
        tree.each {categorie->
            categorie.each { category ->
                if (category) {
                    println "category ${category.key}"
                    if (category.key == 'tipo_de_cliente')
                        tipocli = category.value
                    if(category.key == 'ingenieria_en_sitio' && category.value) {
                        sitio = 'sitio'
                        recursos = category.value
//                        sitioDetail
                        category.value.each {
                            sitioDetail << it.key
                        }
//                        def
                    }
                    if (category.key == 'tecnologia') {
                        println "TECHS ${category.value}"
                        def techList = category.value
                        techList.each { techch ->
                            techch.each { tech ->
                                println "tech $tech"
                                def deviceList = tech.value
                                deviceList.each { device ->
                                    techs << device
                                }
                            }
                        }
                    }
                    if(category.key == 'volumetria') {
                        volumetria = category.value
                    }
                }
            }
        }
        List queryList = []
        techs.each {
            queryList << it + tipocli + sitio + volumetria + sitioDetail
        }
        queryList = queryList.unique()

        println "QUERYS $queryList"

//        List ticketsRecords = queryList.collect {Ticket.findByIdsString(it.join(','))}
        List<Ticket> tickets = Ticket.list()
        List<Regla> rules = Regla.list()
        List selectedDependencies = queryList.collect{
            List<Item> dependencies = []
            it.each {
                Item item = Item.findByCustomId(it as String)
                if(item) dependencies << item
            }
            return dependencies
        }
//        selectedDependencies = selectedDependencies.unique()

        List ticketsRecords = selectedDependencies.collect { depList->
            def matched = rules.findAll {depList.containsAll(it.dependencias)}
//            def asdf = depList as Set<Item>
//            def qwe = Regla.findAllByDescripcion('Para pruebas')
//            Regla.executeQuery("select r from Regla r where r.dependencias.containsAll(:lista)")
//            def miCrit = Regla.createCriteria()
//            def algun = Regla.createCriteria().list() {
//                inList 'dependencias', depList
//            }
//            Regla.findAllByDependenciasInList(asdf)
//            return qwe
            return matched
        }
//        List ticketsRecords = queryList.collect {paramsList-> tickets.find {it.idsList.containsAll(paramsList)}}
        ticketsRecords.removeAll([null, []])
        println "ticketsRecords $ticketsRecords"

//        [[tipo_de_cliente:privado],
//         [:],
//         [tecnologia:
//                  [
//                          [firewall:
//                                   [
//                                           [firewall_firewall/nat,
//                                            firewall_ips,
//                                            firewall_antivirus]]],
//                          [ips:
//                                   [
//                                           [ips_firewall/nat,
//                                            ips_application_control,
//                                            ips_ha],
//                                           [ips_firewall/nat,
//                                            ips_application_control,
//                                            ips_ha,
//                                            ips_vpn_ssl,
//                                            ips_vpn_ipsec]]]]]]

        render (ticketsRecords as JSON)
//        render ([cc:12, es: 4, rq: 1, acs:8] as JSON)
    }
}
