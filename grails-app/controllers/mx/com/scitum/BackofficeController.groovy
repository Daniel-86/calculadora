package mx.com.scitum

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
//@Secured(['permitAll'])
class BackofficeController {

    def list() {
        if(params.itemId) {
            redirect(controller: 'calculadora', action: 'list')
        }
    }

    def listAvailableDependencies() {
//        List dependencies = []
////        dependencies << Categoria.list(fetch: [conceptos: 'lazy', componentes: 'lazy']).flatten()
////        def asdf = Concepto.list(fetch: [padre: 'lazy', categoria: 'lazy'], max: 1, offset: 4)
////        def fgsdf = Concepto.list(fetch: [padre: 'lazy', categoria: 'lazy'], max: 1, offset: 5)
//        dependencies << Concepto.list(fetch: [padre: 'lazy', categoria: 'lazy']).flatten()
//        dependencies << ConceptoEspecial.list(padre: 'lazy', categoria: 'lazy').flatten()
////        dependencies << Propiedad.list().flatten()
//        println "clase ${dependencies.class}  - ${dependencies.flatten()}"
//        def results = [:]
//        results.available = dependencies.flatten()
//        render (results as JSON)

        List availableDependencies = Item.list()
        def results = [:]
        results.available = availableDependencies
        render (results as JSON)

    }

    def editTicket() {
        render view: '/backoffice/edit-ticket', model: [ticketId: params.id]
    }

    def editFactor() {def algo = params
        render view: '/backoffice/create-factor', model: [factorId: params.id]
    }

    def dependenciesData() {
        Regla regla = Regla.get(params.id)
        def dependencies = regla?.dependencias?: []
        def all = Item.list()
        all.removeAll(dependencies)
        def data = [available: all, rule: regla]
        respond data
    }
}
