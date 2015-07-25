package mx.com.scitum

import grails.plugin.springsecurity.annotation.Secured

//@Secured(['ROLE_USER'])
@Secured(['permitAll'])
class Factor extends Regla{

//    String descripcion
    Double factor
    Integer lowerLimit
    Integer upperLimit
    Integer range
    String applyTo = 'all'
    Integer step = 1

    static transients = ['range']

    static constraints = {
        lowerLimit nullable: true, validator: {val, obj-> if(val && obj.upperLimit) {return val <= obj.upperLimit}}
        upperLimit nullable: true, validator: {val, obj-> if(val && obj.lowerLimit) {return val >= obj.lowerLimit}}
    }

    def getRange() {
        return upperLimit - lowerLimit
    }

}
