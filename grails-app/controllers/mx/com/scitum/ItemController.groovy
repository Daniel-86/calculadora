package mx.com.scitum

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class ItemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Item.list(params), model:[itemInstanceCount: Item.count()]
    }

    def show(Item itemInstance) {
        respond itemInstance
    }

    def create() {
        respond new Item(params)
    }

    @Transactional
    def save(Item itemInstance) {
        if (itemInstance == null) {
            notFound()
            return
        }

        if (itemInstance.hasErrors()) {
            respond itemInstance.errors, view:'create'
            return
        }

        itemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'item.label', default: 'Item'), itemInstance.id])
                redirect itemInstance
            }
            '*' { respond itemInstance, [status: CREATED] }
        }
    }

    def edit(Item itemInstance) {
        respond itemInstance
    }

//    @Transactional
    def update() {
        Item itemInstance = request.JSON.id? Item.get(request.JSON.id): Item.findByCustomId(request.JSON.customId)
//        itemInstance = Item.get(1)
        if (itemInstance == null) {
            notFound()
            return
        }

        def lastVisibleStatus = itemInstance.visible
        bindData(itemInstance, request.JSON, [include: ['nombre', 'descripcion', 'visible']])
        if(lastVisibleStatus != itemInstance.visible) {
            if(itemInstance instanceof ConceptoEspecial) {
                itemInstance.propiedades.each {
                    it.visible = !lastVisibleStatus
                    it.save(flush: true)
                }
                itemInstance.conceptosE.each {
                    it.visible = !lastVisibleStatus
                    it.save(flush: true)
                }
            }
            else if(itemInstance instanceof Categoria) {
                itemInstance.componentes.each {ConceptoEspecial c->
                    c.visible = !lastVisibleStatus
                    c.propiedades.each {
                        it.visible = !lastVisibleStatus
                        it.save(flush: true)
                    }
                    c.conceptosE.each {
                        it.visible = !lastVisibleStatus
                        it.save(flush: true)
                    }
                    c.save(flush: true)
                }
                itemInstance.conceptos.each {
                    it.visible = !lastVisibleStatus
                    it.save(flush: true)
                }
            }
        }
//        itemInstance.setCustomId(itemInstance.nombre)

        if (itemInstance.hasErrors()) {
            respond itemInstance.errors, view:'edit'
            return
        }

        itemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Item.label', default: 'Item'), itemInstance.id])
                redirect itemInstance
            }
            '*'{ respond itemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Item itemInstance) {

        if (itemInstance == null) {
            notFound()
            return
        }

        itemInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Item.label', default: 'Item'), itemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
