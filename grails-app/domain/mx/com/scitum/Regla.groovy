package mx.com.scitum

class Regla {

    String nombre = 'default'
    String descripcion
    List dependencies

    static hasMany = [dependencias: Item]
    static transients = ['dependencies']

    static constraints = {
//        dependencias nullable: false
        descripcion nullable: true, blank: true
    }

    def getDependencies() {
        return (Dependencia.findAllByRule(this)?.collect{it.item})
    }
}
