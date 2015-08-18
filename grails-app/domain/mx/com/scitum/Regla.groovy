package mx.com.scitum

import mx.com.scitum.helpers.CleaningStuff

class Regla {

    String nombre = 'default'
    String descripcion
    List dependencies
    String customId

//    static hasMany = [dependencias: Item]
    static transients = ['dependencies', 'dependencyDetail']

    static constraints = {
//        dependencias nullable: false
        descripcion nullable: true, blank: true
        customId unique: true, blank: false
    }

    def getDependencies() {
        return (Dependencia.findAllByRule(this)?.collect{it.item})
    }

    def getDependencyDetail() {
        return (Dependencia.findAllByRule(this))
    }

    void setCustomId(String value) {
        customId = CleaningStuff.makeSafeURL(value)
    }

    void setNombre(String nombre) {
        this.nombre = nombre
        String tentativeId = CleaningStuff.makeSafeURL(nombre)
        def existsCount = Regla.findAllByCustomId(tentativeId)
        customId = tentativeId + (existsCount?.size()?: '')
    }
}
