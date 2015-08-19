package mx.com.scitum

import mx.com.scitum.helpers.CleaningStuff

class Item {

    String descripcion
    String customId
    String nombre
    Boolean visible = true

    static constraints = {
        customId unique: true
    }

    void setCustomId(String value) {
//        customId = CleaningStuff.makeSafeURL(value)
        String tentativeId = CleaningStuff.makeSafeURL(value)
        def existsCount = Item.findAllByCustomIdIlike(tentativeId+'%')
        if(!this.id && existsCount?.size())
            def asdf = 'asdf'
//        if(this.id && existsCount?.size())
        customId = tentativeId + (!this.id && existsCount?.size()? existsCount.size(): '')
    }

//    void setNombre(String nombre) {
//        this.nombre = nombre
//        String tentativeId = CleaningStuff.makeSafeURL(nombre)
//        def existsCount = Item.findAllByCustomId(tentativeId)
//        customId = tentativeId + (existsCount?.size()?: '')
//    }
}
