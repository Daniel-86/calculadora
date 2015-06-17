package mx.com.scitum

class Concepto {

    String descripcion
    Float costo
    Categoria categoria
    Boolean multiple = false

    static belongsTo = [categoria: Categoria, padre: ConceptoEspecial]

    static constraints = {
        categoria nullable: true
        padre nullable: true
    }
}
