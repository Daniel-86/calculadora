package mx.com.scitum

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class TicketController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Ticket.list(params), model:[ticketInstanceCount: Ticket.count()]
    }

    def list() {def asdf = Ticket.list()
//        respond Ticket.list()
        render (Ticket.list() as JSON)
    }

    def show(Ticket ticketInstance) {
        respond ticketInstance
    }

    def create() {
        respond new Ticket(params)
    }

    @Transactional
    def save() {
        Ticket ticketInstance = new Ticket()
        bindData(ticketInstance, request.JSON, [include: ['cc', 'es', 'acs', 'rq', 'nombre', 'descripcion']])
        def dependenciasJSON = request.JSON.dependencias
        dependenciasJSON.each { String id->
            ticketInstance.addToDependencias(Item.findByCustomId(id))
        }

        if (ticketInstance == null) {
            notFound()
            return
        }

        if (ticketInstance.hasErrors()) {
            respond ticketInstance.errors, view:'create'
            return
        }

        ticketInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ticket.label', default: 'Ticket'), ticketInstance.id])
                redirect ticketInstance
            }
            '*' { respond ticketInstance, [status: CREATED] }
        }
    }

    def edit(Ticket ticketInstance) {
        respond ticketInstance
    }

    @Transactional
    def update() {
        def dats = request.JSON
        Ticket ticketInstance = Ticket.get(request.JSON.id)
        if (ticketInstance == null) {
            notFound()
            return
        }
        bindData(ticketInstance, request.JSON, [include: ['cc', 'es', 'acs', 'rq', 'nombre', 'descripcion']])
        def dependenciasJSON = request.JSON.dependencias
        def dependencies = []
        dependenciasJSON.each { String id->
            Item item = Item.findByCustomId(id)
            if(item) {dependencies << item}
//            ticketInstance.addToDependencias(Item.findByCustomId(id))
        }
        def deletions = ticketInstance.dependencias.collect()
        deletions.removeAll(dependencies)
        deletions.each {ticketInstance.removeFromDependencias(it)}
        dependencies.each {ticketInstance.addToDependencias(it)}

        if (ticketInstance.hasErrors()) {
            respond ticketInstance.errors, view:'edit'
            return
        }

        ticketInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Ticket.label', default: 'Ticket'), ticketInstance.id])
                redirect ticketInstance
            }
            '*'{ respond ticketInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Ticket ticketInstance) {

        if (ticketInstance == null) {
            notFound()
            return
        }

        ticketInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Ticket.label', default: 'Ticket'), ticketInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def dependenciesData() {
        Ticket ticket = Ticket.get(params.id)
        def dependencies = ticket?.dependencias?: []
        def all = Item.list()
        all.removeAll(dependencies)
        def data = [available: all, ticket: ticket]
        respond data
    }
}
