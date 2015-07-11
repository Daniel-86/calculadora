package mx.com.scitum

class Regla {

    String nombre = 'default'
    String descripcion
    static hasMany = [dependencias: Item]

    static constraints = {
//        dependencias nullable: false
        descripcion nullable: true, blank: true
    }
}
