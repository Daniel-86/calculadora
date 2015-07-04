package mx.com.scitum



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FactorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Factor.list(params), model:[factorInstanceCount: Factor.count()]
    }

    def show(Factor factorInstance) {
        respond factorInstance
    }

    def create() {
        respond new Factor(params)
    }

    @Transactional
    def save() {
        Factor factorInstance = new Factor()
        bindData(factorInstance, request.JSON, [include: ['factor', 'lowerLimit', 'upperLimit', 'descripcion']])
        def dependenciasJSON = request.JSON.dependencias
        dependenciasJSON.each { String id->
            factorInstance.addToDependencias(Item.findByCustomId(id))
        }
        
        if (factorInstance == null) {
            notFound()
            return
        }

        if (factorInstance.hasErrors()) {
            respond factorInstance.errors, view:'create'
            return
        }

        factorInstance.save flush:true, failOnError: false

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'factor.label', default: 'Factor'), factorInstance.id])
                redirect factorInstance
            }
            '*' { respond factorInstance, [status: CREATED] }
        }
    }

    def edit(Factor factorInstance) {
        respond factorInstance
    }

    @Transactional
    def update(Factor factorInstance) {
        if (factorInstance == null) {
            notFound()
            return
        }

        if (factorInstance.hasErrors()) {
            respond factorInstance.errors, view:'edit'
            return
        }

        factorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Factor.label', default: 'Factor'), factorInstance.id])
                redirect factorInstance
            }
            '*'{ respond factorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Factor factorInstance) {

        if (factorInstance == null) {
            notFound()
            return
        }

        factorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Factor.label', default: 'Factor'), factorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'factor.label', default: 'Factor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
