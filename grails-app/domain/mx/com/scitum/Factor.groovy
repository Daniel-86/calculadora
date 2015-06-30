package mx.com.scitum

class Factor extends Regla{

    String descripcion
    Double factor
    Integer lowerLimit
    Integer upperLimit
    Integer range
    String idsDependecies
    List dependenciesList

    static transients = ['range', 'dependenciesList']

    static constraints = {
        lowerLimit nullable: true, validator: {val, obj-> if(val && obj.upperLimit) {return val <= obj.upperLimit}}
        upperLimit nullable: true, validator: {val, obj-> if(val && obj.lowerLimit) {return val >= obj.lowerLimit}}
    }

    def getRange() {
        return upperLimit - lowerLimit
    }


    List getDependenciesList() {
        return idsDependecies? idsDependecies.tokenize(',')*.trim(): []
    }

    void setDependenciesList(List dependenciesList) {
        def tempList = dependenciesList*.trim()
        idsDependecies = tempList.sort().join(', ')
        this.dependenciesList = tempList
    }
}
