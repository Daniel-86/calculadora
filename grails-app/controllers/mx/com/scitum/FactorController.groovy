package mx.com.scitum

import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class FactorController {

    static allowedMethods = [save: ["POST", 'OPTIONS'], update: ["PUT", 'OPTIONS'], delete: ["DELETE", 'OPTIONS']]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Factor.list(params), model:[factorInstanceCount: Factor.count()]
    }

    def list() {
        respond Factor.list()
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
        bindData(factorInstance, request.JSON, [include: ['factor', 'lowerLimit', 'upperLimit', 'descripcion',
                                                          'nombre']])
        def target = request.JSON.target
        target.each {
            factorInstance.addToTarget(Target."$it")
        }

        def dependenciasJSON = request.JSON.dependencias
        def dependencies = []
        dependenciasJSON.each { dependency->
            Item item = Item.findByCustomId(dependency.item?.customId)
            if(item) {dependencies << item}
        }

//        def current = factorInstance.dependencyDetail
//        def deletions = current.findAll {!dependencies.contains(it.item)}
        def newOnes = dependencies
//        def updates = current.findAll {!deletions.contains(it)}
//        updates.each {ite->
//            def dep = dependenciasJSON.find {ite.item.customId == it.item.customId}
//            if(!dep) return
//            ite.lowerLimit = dep.lowerLimit == JSONObject.NULL? null: dep.lowerLimit
//            ite.upperLimit = dep.upperLimit == JSONObject.NULL? null: dep.upperLimit
//            ite.step = dep.step == JSONObject.NULL? null: dep.step
//        }
//        deletions*.delete(flush: true)

//        updates*.save(flush: true)


        if (factorInstance.hasErrors()) {
            respond factorInstance.errors, view:'create'
            return
        }

        factorInstance.save flush:true, failOnError: false

        newOnes.each {
            def aux = new Dependencia(rule: factorInstance, item: it)
            aux.save(flush: true)
        }

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
    def update() {
        Factor factorInstance = Factor.get(request.JSON.id)
        if (factorInstance == null) {
            notFound()
            return
        }
        bindData(factorInstance, request.JSON, [include: ['factor', 'lowerLimit', 'upperLimit', 'descripcion',
                                                          'nombre']])

        def target = request.JSON.target
        target = target.collect {Target."$it"}
//        def intersects = factorInstance.target.intersect(target)
        def newTarget = target - factorInstance.target
        def droppedOnes = factorInstance.target - target
        droppedOnes.each {
            factorInstance.removeFromTarget(it)
        }
        newTarget.each {
            factorInstance.addToTarget(it)
        }

        def dependenciasJSON = request.JSON.dependencias
        def dependencies = []
        dependenciasJSON.each { dependency->
            Item item = Item.findByCustomId(dependency.item?.customId)
            if(item) {dependencies << item}
        }

        def current = factorInstance.dependencyDetail
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
            def aux = new Dependencia(rule: factorInstance, item: it)
            aux.save(flush: true)
        }
        updates*.save(flush: true)


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
    def delete() {

        def itemData = request.JSON.item; println "itemData $itemData"

        def itemId = params.id
        Factor factorInstance = itemId? Factor.get(itemId): null

//        Factor factorInstance = itemData?.id? Factor.get(itemData.id): null

        if (factorInstance == null) {
            notFound()
            return
        }

        def dependencies = factorInstance.dependencyDetail
        dependencies.each {it.delete(flush: true)}

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
    
    def dependenciesData() {
        Factor factor = Factor.get(params.id)
        def dependencies = factor?.dependencies?.collect {it.customId}?: []
        def all = dependencies? Item.findAllByCustomIdNotInList(dependencies): Item.list()
//        all.removeAll(dependencies)
        def data = [available: all, factor: factor]
        respond data
    }
}
