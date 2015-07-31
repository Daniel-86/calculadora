package mx.com.scitum



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PropiedadController {

    def unmarshallerService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Propiedad.list(params), model:[propiedadInstanceCount: Propiedad.count()]
    }

    def show(Propiedad propiedadInstance) {
        respond propiedadInstance
    }

    def create() {
        respond new Propiedad(params)
    }

    @Transactional
    def save() {
        Propiedad propiedadInstance = new Propiedad()
        bindData(propiedadInstance, request.JSON, [include: ['customId', 'descripcion', 'tipo']])

        def parentJSON = request.JSON.parent
        ConceptoEspecial parent = parentJSON.id?
                ConceptoEspecial.get(parentJSON.id):
                ConceptoEspecial.findByCustomId(parentJSON.customId)

        if (propiedadInstance == null || !parent) {
            notFound()
            return
        }

        if (propiedadInstance.hasErrors()) {
            respond propiedadInstance.errors, view:'create'
            return
        }

        parent.addToPropiedades(propiedadInstance)
        parent.save(flush: true)

//        propiedadInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'propiedad.label', default: 'Propiedad'), propiedadInstance.id])
                redirect propiedadInstance
            }
            '*' { respond propiedadInstance, [status: CREATED] }
        }
    }

    def edit(Propiedad propiedadInstance) {
        respond propiedadInstance
    }

    @Transactional
    def update(Propiedad propiedadInstance) {
        if (propiedadInstance == null) {
            notFound()
            return
        }

        if (propiedadInstance.hasErrors()) {
            respond propiedadInstance.errors, view:'edit'
            return
        }

        propiedadInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Propiedad.label', default: 'Propiedad'), propiedadInstance.id])
                redirect propiedadInstance
            }
            '*'{ respond propiedadInstance, [status: OK] }
        }
    }

    @Transactional
    def delete() {

        Propiedad propiedadInstance = request.JSON.id? Propiedad.get(request.JSON.id): Propiedad
                .findByCustomId(request.JSON.customId)

        if (propiedadInstance == null) {
            notFound()
            return
        }

        ConceptoEspecial parent = propiedadInstance.propietario
        unmarshallerService.removeDependency(parent, propiedadInstance)



//        parent.removeFromPropiedades(propiedadInstance)
////
//        parent.save(flush: true)
//        propiedadInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Propiedad.label', default: 'Propiedad'), propiedadInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'propiedad.label', default: 'Propiedad'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
