package mx.com.scitum

import mx.com.scitum.helpers.CleaningStuff

class Item {

    String descripcion
    String customId
    String nombre
    Boolean visible = true
    Boolean eligible = true
    Boolean single = false

    static constraints = {
        customId unique: true
        volumetry min: 1
    }

    void setCustomId(String value) {
        String tentativeId = CleaningStuff.makeSafeURL(value)
        def existsCount = Item.findAllByCustomIdIlike(tentativeId+'%')
        customId = tentativeId + (!this.id && existsCount?.size()? existsCount.size(): '')
    }

//    void setNombre(String nombre) {
//        this.nombre = nombre
//        String tentativeId = CleaningStuff.makeSafeURL(nombre)
//        def existsCount = Item.findAllByCustomId(tentativeId)
//        customId = tentativeId + (existsCount?.size()?: '')
//    }
}
