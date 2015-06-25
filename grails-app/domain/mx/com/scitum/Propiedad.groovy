package mx.com.scitum

class Propiedad {

    String descripcion
    String tipo = 'String'
    String valor
    String customId

    static belongsTo = [propietario: ConceptoEspecial]

    static constraints = {
        valor nullable: true
        customId unique: true
    }
}
