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
        customId = CleaningStuff.makeSafeURL(value)
    }

    void setNombre(String nombre) {
        this.nombre = nombre
        String tentativeId = CleaningStuff.makeSafeURL(nombre)
        def existsCount = Item.findAllByCustomId(tentativeId)
        customId = tentativeId + (existsCount?.size()?: '')
    }
}
