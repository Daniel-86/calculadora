package mx.com.scitum

class Dependencia {

//    Item item
//    Regla rule
    Integer lowerLimit
    Integer upperLimit
    Integer step = 1

    static belongsTo = [rule: Regla, item: Item]

    static constraints = {
        lowerLimit nullable: true, validator: {val, obj-> if(val && obj.upperLimit) {return val <= obj.upperLimit}}
        upperLimit nullable: true, validator: {val, obj-> if(val && obj.lowerLimit) {return val >= obj.lowerLimit}}
    }
}
