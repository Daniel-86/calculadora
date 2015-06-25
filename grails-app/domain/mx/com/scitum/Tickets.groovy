package mx.com.scitum

class Tickets {

    Integer cc
    Integer es
    Integer rq
    Integer acs
    String idsString

    static transients = ['idsList']

    static constraints = {
        idsString unique: true, validator: {val, obj->
            if(!val || val.trim() == '') return false
            def dirty = val.tokenize(',')*.trim()
            def cleaned = dirty.unique()
            return dirty.size() == cleaned.size()
        }
    }

    def getIdsList() {
        return idsString? idsString.tokenize(',')*.trim(): []
    }

    def setIdsList(List ids) {
        def tempList = ids*.trim()
        idsString = tempList.join(', ')
        idsList = tempList
    }

    def dependenciesCount() {
        return getIdsList().size()
    }

    def addToIds(String id) {
        id = id.trim()
        if(!idsList.contains(id)) {
            idsString += dependenciesCount() > 1? ", $id": id
            idsList << id
        }
    }

    def removeFromIds(String id) {
        id = id.trim()
        if(idsList.remove(id))
            idsString = idsList.join(', ')
    }

    def addToIds(List ids) {
        ids.each {String id-> addToIds(id)}
    }

    def removeFromIds(List ids) {
        ids.each {String id-> removeFromIds(id)}
    }
}
