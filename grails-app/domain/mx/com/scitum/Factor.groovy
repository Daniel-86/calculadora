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
//    String idsDependecies
//    List dependenciesList

//    static transients = ['range', 'dependenciesList']
    static transients = ['range']

    static constraints = {
        lowerLimit nullable: true, validator: {val, obj-> if(val && obj.upperLimit) {return val <= obj.upperLimit}}
        upperLimit nullable: true, validator: {val, obj-> if(val && obj.lowerLimit) {return val >= obj.lowerLimit}}
//        descripcion nullable: true, blank: true
//        idsDependecies nullable: true
    }

    def getRange() {
        return upperLimit - lowerLimit
    }


//    List getDependenciesList() {
//        return idsDependecies? idsDependecies.tokenize(',')*.trim(): []
//    }
//
//    void setDependenciesList(List dependenciesList) {
//        def tempList = dependenciesList*.trim()
//        idsDependecies = tempList.sort().join(', ')
//        this.dependenciesList = tempList
//    }
}
