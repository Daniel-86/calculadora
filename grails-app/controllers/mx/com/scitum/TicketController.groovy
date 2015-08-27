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

//    @Transactional
    def save() {
        def asdf = request.JSON
        Ticket ticketInstance = new Ticket()
        bindData(ticketInstance, request.JSON, [include: ['cc', 'es', 'acs', 'rq', 'nombre', 'descripcion']])
        ticketInstance.setCustomId(ticketInstance.nombre)
        def dependenciasJSON = request.JSON.dependencias
        def dependencies = []
        dependenciasJSON.each { dependency->
            Item item = Item.findByCustomId(dependency.item?.customId)
            if(item) {dependencies << [item:item, upperLimit: dependency.upperLimit, lowerLimit: dependency.lowerLimit]}
        }

        def newOnes = dependencies

        if (ticketInstance.hasErrors()) {
            respond ticketInstance.errors, view:'create'
            return
        }

        ticketInstance.save flush:true

        newOnes.each {
            def upper = (it.upperLimit &&
                    (it.upperLimit in Number ||
                            (it.upperLimit in String && it.upperLimit.isNumber())))?
                    it.upperLimit: null
            def aux = new Dependencia(rule: ticketInstance,
                    item: it.item,
                    lowerLimit: it.lowerLimit,
                    upperLimit: upper)
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

//    @Transactional
    def update() {
        def dats = request.JSON
        Ticket ticketInstance = Ticket.get(request.JSON.id)
        if (ticketInstance == null) {
            notFound()
            return
        }
        bindData(ticketInstance, request.JSON, [include: ['cc', 'es', 'acs', 'rq', 'nombre', 'descripcion']])
        ticketInstance.setCustomId(ticketInstance.nombre)
        def dependenciasJSON = request.JSON.dependencias
        def dependencies = []
        dependenciasJSON.each { dependency->
            Item item = Item.findByCustomId(dependency.item?.customId)
            def depData = [item:item, upperLimit: dependency.upperLimit, lowerLimit: dependency.lowerLimit]
            if(item) {dependencies << depData}
        }

        def current = ticketInstance.dependencyDetail
        def deletions = current.findAll {!dependencies.item.contains(it.item)}
        def newOnes = dependencies.findAll {!current.item.contains(it.item)}
        def updates = current.findAll {!deletions.contains(it)}
        updates.each {ite->
            def dep = dependenciasJSON.find {ite.item.customId == it.item.customId}
            if(!dep) return
            println "\nvalor${dep.upperLimit}"
            println "es json nulo ${dep.upperLimit == JSONObject.NULL}"
            println "es numero ${dep.upperLimit in Number}"
            println "es string ${dep.upperLimit in String}"
            println "es string numero ${dep.upperLimit in String && dep.upperLimit.isNumber()}"
            ite.lowerLimit = dep.lowerLimit == JSONObject.NULL? null: dep.lowerLimit?.toInteger()
            ite.upperLimit = (dep.upperLimit == JSONObject.NULL || (dep.upperLimit in
                    String && !(dep.upperLimit.isNumber())))?
                    null: dep.upperLimit?.toInteger()
            ite.step = dep.step == JSONObject.NULL? null: dep.step
            println "despues ${ite.upperLimit}"
        }
        deletions*.delete(flush: true)
        newOnes.each {
            def upper = (it.upperLimit &&
                    (it.upperLimit in Number ||
                            (it.upperLimit in String && it.upperLimit.isNumber())))?
                    it.upperLimit: null
            def aux = new Dependencia(rule: ticketInstance,
                    item: it.item,
                    lowerLimit: it.lowerLimit,
                    upperLimit: upper)
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
        def dependencies = ticket?.dependencies?.collect {it.customId}?: []
        def all = dependencies? Item.findAllByCustomIdNotInList(dependencies): Item.list()
//        all.removeAll(dependencies)
        def data = [available: all, ticket: ticket]
        respond data
    }
}
