package mx.com.scitum

class ConceptoEspecial {

    String descripcion
    List propiedades

    static hasMany = [propiedades: Propiedad]
    static belongsTo = [categoria: Categoria, padre: ConceptoEspecial]

    static constraints = {
        categoria nullable: true
        padre nullable: true
    }
}
