package mx.com.scitum

class Regla {

    static hasMany = [dependencias: Item]

    static constraints = {
//        dependencias nullable: false
    }
}
