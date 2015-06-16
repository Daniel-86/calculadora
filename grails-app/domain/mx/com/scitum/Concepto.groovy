package mx.com.scitum

class Concepto {

    String descripcion
    Float costo
    Categoria categoria
    Boolean multiple = false

    static belongsTo = [categoria: Categoria]

    static constraints = {
//        categoria nullable: false
    }
}
