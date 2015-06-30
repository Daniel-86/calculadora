package mx.com.scitum

class Categoria {

    String descripcion
    Boolean multiple = false
    Boolean required = true
    List conceptos
    List componentes
    String customId

    String nodeType
    static transients = ['nodeType']

    static hasMany = [conceptos: Concepto, componentes: ConceptoEspecial]

    static constraints = {
        nodeType bindable: true
        customId unique: true
    }

    def getNodeType() {
        'ROOT'
    }

    static def NODE_TYPE() {'ROOT'}

//    def setNodeType(String s) {}

//    static fetchMode = [conceptos: 'eager', ]

//    def getConceptos() {
//        println Concepto.list()
//        return (Concepto.grep{it.categoria == this})
//        return (Concepto.findAllByCategoria(this))
//    }

//    def setConceptos(conceptos) {
//        conceptos.each {
//            this.addToConceptos(it)
//        }
//    }
}
