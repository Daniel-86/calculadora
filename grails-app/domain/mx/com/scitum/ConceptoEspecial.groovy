package mx.com.scitum

class ConceptoEspecial extends Item {

//    String descripcion
    List propiedades
    List conceptosE
//    String customId

    String nodeType
    static transients = ['nodeType']
    static hasMany = [propiedades: Propiedad, conceptosE: Concepto]
    static belongsTo = [categoria: Categoria, padre: ConceptoEspecial]

    static constraints = {
        categoria nullable: true
        padre nullable: true
        nodeType bindable: true
//        customId unique: true
    }

    def getNodeType() {
        'BRANCH'
    }

    static mapping = {
        propiedades cascade: "all-delete-orphan"
    }
    
//    def setNodeType(String s) {}
}
