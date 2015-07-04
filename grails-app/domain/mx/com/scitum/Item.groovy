package mx.com.scitum

class Item {

    String descripcion
    String customId

    static constraints = {
        customId unique: true
    }
}
