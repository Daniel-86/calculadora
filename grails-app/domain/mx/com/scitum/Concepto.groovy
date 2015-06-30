package mx.com.scitum

class Concepto extends Item{

//    String descripcion
    Float costo
    Categoria categoria
    Boolean multiple = false
    String customId

    String nodeType
    static transients = ['nodeType']
    static belongsTo = [categoria: Categoria, padre: ConceptoEspecial]

    static constraints = {
        categoria nullable: true
        padre nullable: true
        nodeType bindable: true
        customId unique: true
    }

    def getNodeType() {
        'LEAF'
    }

//    def setNodeType(String s) {}
}
