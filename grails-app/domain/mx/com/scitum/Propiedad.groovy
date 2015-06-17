package mx.com.scitum

class Propiedad {

    String descripcion
    String tipo = 'Integer'
    String valor

    static belongsTo = [propietario: ConceptoEspecial]

    static constraints = {
    }
}
