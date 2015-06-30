package mx.com.scitum

import grails.converters.JSON

class CalculadoraController {

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

    def calcular() {
        def requestData = params.postData
//        println "requestData $requestData"
//        println "params $params"
        println "postData ${request.JSON.postData}"

        def tree = request.JSON.postData

        String tipocli
        String sitio
        String volumetria
        List techs = []
        tree.each {categorie->
            categorie.each { category ->
                if (category) {
                    println "category ${category.key}"
                    if (category.key == 'tipo_de_cliente')
                        tipocli = category.value
                    if(category.key == 'ingenieria_en_sitio' && category.value)
                        sitio = 'sitio'
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
            queryList << it + tipocli + sitio + volumetria
        }
        queryList = queryList.unique()

        println "QUERYS $queryList"

//        List ticketsRecords = queryList.collect {Ticket.findByIdsString(it.join(','))}
        List<Ticket> tickets = Ticket.list()
        List ticketsRecords = queryList.collect {paramsList-> tickets.find {it.idsList.containsAll(paramsList)}}
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
