package mx.com.scitum

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.json.JSONObject

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class TicketController {

    static allowedMethods = [save: "POST", update: "PUT", delete: ["DELETE", 'POST', 'GET']]

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
        def dependencies = []
        dependenciasJSON.each { dependency->
            Item item = Item.findByCustomId(dependency.item?.customId)
            if(item) {dependencies << item}
        }

        def newOnes = dependencies

        if (ticketInstance.hasErrors()) {
            respond ticketInstance.errors, view:'create'
            return
        }

        ticketInstance.save flush:true

        newOnes.each {
            def aux = new Dependencia(rule: ticketInstance, item: it)
            aux.save(flush: true)
        }

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
        dependenciasJSON.each { dependency->
            Item item = Item.findByCustomId(dependency.item?.customId)
            if(item) {dependencies << item}
        }

        def current = ticketInstance.dependencyDetail
        def deletions = current.findAll {!dependencies.contains(it.item)}
        def newOnes = dependencies.findAll {!current.item.contains(it)}
        def updates = current.findAll {!deletions.contains(it)}
        updates.each {ite->
            def dep = dependenciasJSON.find {ite.item.customId == it.item.customId}
            if(!dep) return
            ite.lowerLimit = dep.lowerLimit == JSONObject.NULL? null: dep.lowerLimit
            ite.upperLimit = dep.upperLimit == JSONObject.NULL? null: dep.upperLimit
            ite.step = dep.step == JSONObject.NULL? null: dep.step
        }
        deletions*.delete(flush: true)
        newOnes.each {
            def aux = new Dependencia(rule: ticketInstance, item: it)
            aux.save(flush: true)
        }
        updates*.save(flush: true)

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

        def dependencies = ticketInstance.dependencyDetail
        dependencies.each {it.delete(flush: true)}

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
        def dependencies = ticket?.dependencias?.collect {it.customId}?: []
        def all = dependencies? Item.findAllByCustomIdNotInList(dependencies): Item.list()
//        all.removeAll(dependencies)
        def data = [available: all, ticket: ticket]
        respond data
    }
}
