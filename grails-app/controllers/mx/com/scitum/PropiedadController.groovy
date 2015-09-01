package mx.com.scitum

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class PropiedadController {

    def unmarshallerService

    static allowedMethods = [save: ["POST"], update: ["PUT"], delete: ["DELETE"]]

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

//    @Transactional
    def save() {

        Propiedad propiedadInstance = new Propiedad()
        propiedadInstance.setNombre(request.JSON.nombre)
        propiedadInstance.setDescripcion(request.JSON.descripcion)
        propiedadInstance.setTipo(request.JSON.tipo)
//        bindData(propiedadInstance, request.JSON, [include: ['nombre', 'descripcion', 'tipo']])

        def parentJSON = request.JSON.parent
        ConceptoEspecial parent = parentJSON?.id?
                ConceptoEspecial.get(parentJSON.id):
                ConceptoEspecial.findByCustomId(parentJSON?.customId)

        if (propiedadInstance == null || !parent) {
            notFound()
            return
        }

        propiedadInstance.setCustomId(parent.customId+'_'+propiedadInstance.nombre)
//        propiedadInstance.propietario = parent

//        propiedadInstance.validate()
//        propiedadInstance.save(flush: true)

        parent.addToPropiedades(propiedadInstance)

//        propiedadInstance.validate()
//        propiedadInstance.save(flush: true)
        if (propiedadInstance.hasErrors()) {
            respond propiedadInstance.errors, view:'create'
            return
        }

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
//        if(request.method == 'OPTIONS') {respond OK; return;}
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

//    @Transactional
    def delete() {
//        if(request.method == 'OPTIONS') {respond OK; return;}
        Propiedad propiedadInstance = request.JSON.id? Propiedad.get(request.JSON.id): Propiedad
                .findByCustomId(request.JSON.customId)

        if (propiedadInstance == null) {
            notFound()
            return
        }

        ConceptoEspecial parent = Item.get(propiedadInstance.propietario.id)
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

    def listTypes() {
        respond FieldType.values()?.collect {it.toString()}
    }
}
