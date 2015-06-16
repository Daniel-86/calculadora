package mx.com.scitum

class Categoria {

    String descripcion
    Boolean multiple = false
    Boolean required = true
    List conceptos

    static hasMany = [conceptos: Concepto]

    static constraints = {
    }

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
