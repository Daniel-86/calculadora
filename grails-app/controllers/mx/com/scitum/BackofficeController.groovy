package mx.com.scitum

import grails.converters.JSON

class BackofficeController {

    def list() {
        if(params.itemId) {
            redirect(controller: 'calculadora', action: 'list')
        }
    }

    def listAvailableDependencies() {
        List dependencies = []
//        dependencies << Categoria.list(fetch: [conceptos: 'lazy', componentes: 'lazy']).flatten()
        def asdf = Concepto.list(fetch: [padre: 'lazy', categoria: 'lazy'], max: 1, offset: 4)
        def fgsdf = Concepto.list(fetch: [padre: 'lazy', categoria: 'lazy'], max: 1, offset: 5)
        dependencies << Concepto.list(fetch: [padre: 'lazy', categoria: 'lazy']).flatten()
        dependencies << ConceptoEspecial.list(padre: 'lazy', categoria: 'lazy').flatten()
//        dependencies << Propiedad.list().flatten()
        println "clase ${dependencies.class}  - ${dependencies.flatten()}"
        def results = [:]
        results.available = dependencies.flatten()
        render (results as JSON)
    }
}
