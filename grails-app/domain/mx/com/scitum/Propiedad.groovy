package mx.com.scitum

class Propiedad extends Item{

//    String descripcion
    String tipo = 'String'
    String valor
    FieldType customType = FieldType.TEXT
//    String groupName
//    String customId

    static belongsTo = [propietario: ConceptoEspecial]

    static hasMany = [options: String]

    static constraints = {
        valor nullable: true
//        customId unique: true
    }

    static propsWithOptions = [FieldType.CHECK, FieldType.RADIO]

//    def getGroupName() {
//        if(customType in [FieldType.RADIO, FieldType.CHECK]) { groupName }
//        else null
//    }
}


enum FieldType {
    NUMBER('int', 'number', 'float', 'integer'),
    CHECK('boolean', 'checkbox', 'unique'),
    RADIO('radio', 'multiple'),
    TEXT()


    private def allowedStrings = []

    FieldType(... args) {
        allowedStrings = args
    }

    void setAllowedStrings(allowedStrings) {
    }

    static def resolve(String s) {
        s = s.toLowerCase()
        return values().find {it.allowedStrings.contains(s)}?: TEXT
    }
}
