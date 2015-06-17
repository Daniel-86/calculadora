package mx.com.scitum

class Categoria {

    String descripcion
    Boolean multiple = false
    Boolean required = true
    List conceptos
    List componentes

    static hasMany = [conceptos: Concepto, componentes: ConceptoEspecial]

    static constraints = {
    }

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
