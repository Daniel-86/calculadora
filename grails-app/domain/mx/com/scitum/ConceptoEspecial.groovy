package mx.com.scitum

class ConceptoEspecial {

    String descripcion
    List propiedades
    List conceptosE
    String custiomId

    String nodeType
    static transients = ['nodeType']
    static hasMany = [propiedades: Propiedad, conceptosE: Concepto]
    static belongsTo = [categoria: Categoria, padre: ConceptoEspecial]

    static constraints = {
        categoria nullable: true
        padre nullable: true
        nodeType bindable: true
        custiomId unique: true
    }

    def getNodeType() {
        'BRANCH'
    }
    
//    def setNodeType(String s) {}
}
