import grails.converters.deep.JSON
import mx.com.scitum.Categoria
import mx.com.scitum.Concepto

class BootStrap {

	def customMarshallerRegistrar

    def init = { servletContext ->
		customMarshallerRegistrar.registerMarshallers()

        println "loading categories data"
        Categoria category = new Categoria(
                descripcion: 'Tipo de cliente',
                multiple: false,
                required: true
                )
        [
                new Concepto(descripcion: 'Gobierno', costo: 23),
                new Concepto(descripcion: 'Privado', costo: 2),
                new Concepto(descripcion: 'Financiero', costo: 3)].each {
            category.addToConceptos(it)
        }
        category.save(flush: true, failOnError: true)

        category = new Categoria(
                descripcion: 'Ingeniería en sitio',
                multiple: false,
                required: true)
        [
                new Concepto(descripcion: 'Sí', costo: 1),
                new Concepto(descripcion: 'No', costo: 0)].each {
            category.addToConceptos(it)
        }
        category.save(flush: true, failOnError: true)

        category = new Categoria(
                descripcion: 'Tecnología',
                multiple: true,
                required: true)
        [
                new Concepto(descripcion: 'IPS', costo: 23, multiple: true),
                new Concepto(descripcion: 'Firewall', costo: 2, multiple: true),
                new Concepto(descripcion: 'Filtrado web', costo: 3, multiple: true),
                new Concepto(descripcion: 'Antispam', costo: 123, multiple: true)].each {
            category.addToConceptos(it)
        }
        category.save(flush: true, failOnError: true)

        category = new Categoria(
                descripcion: 'Tipo de cliente',
                multiple: false,
                required: true)
        [
                new Concepto(descripcion: 'Gobierno', costo: 23),
                new Concepto(descripcion: 'Privado', costo: 2),
                new Concepto(descripcion: 'Financiero', costo: 3)].each {
            category.addToConceptos(it)
        }
        category.save(flush: true, failOnError: true)

        println Categoria.list() as JSON
//        println Concepto.list() as JSON
	}
    def destroy = {
    }
}
