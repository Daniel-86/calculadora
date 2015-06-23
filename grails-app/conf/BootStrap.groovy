import mx.com.scitum.Categoria
import mx.com.scitum.Concepto
import mx.com.scitum.ConceptoEspecial
import mx.com.scitum.Propiedad

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
        def arrProp, arrCon
        def tecnologyProps = {
            def lista = [
                new Propiedad(descripcion: 'cantidad', tipo: 'Integer'),
                new Propiedad(descripcion: 'volumetría'),
                new Propiedad(descripcion: 'HA', tipo: 'boolean')
            ]
            return lista
        }
        def tecnologyConcepts = {
            def lista = [
                new Concepto(descripcion: 'Firewall/NAT', costo: 23, multiple: true),
                new Concepto(descripcion: 'VPN IPSEC', costo: 2, multiple: true),
                new Concepto(descripcion: 'VPN SSL', costo: 3, multiple: true),
                new Concepto(descripcion: 'IPS', costo: 3, multiple: true),
                new Concepto(descripcion: 'Application control', costo: 3, multiple: true),
                new Concepto(descripcion: 'URL filtering', costo: 3, multiple: true),
                new Concepto(descripcion: 'Antivirus', costo: 123, multiple: true)
            ]
            return lista
        }

        ConceptoEspecial conceptoEspecial = new ConceptoEspecial(descripcion: 'Firewall')
        arrProp = tecnologyProps()
        arrProp.each {
            conceptoEspecial.addToPropiedades(it)
        }

        arrCon = tecnologyConcepts()
        arrCon.each {
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'IPS')
        arrProp = tecnologyProps()
        arrProp.each {
            conceptoEspecial.addToPropiedades(it)
        }

        arrCon = tecnologyConcepts()
        arrCon.each {
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'Filtrado web')
        arrProp = tecnologyProps()
        arrProp.each {
            conceptoEspecial.addToPropiedades(it)
        }

        arrCon = tecnologyConcepts()
        arrCon.each {
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'Antispam')
        arrProp = tecnologyProps()
                 arrProp.each {
            conceptoEspecial.addToPropiedades(it)
        }

        arrCon = tecnologyConcepts()
        arrCon.each {
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        category.save(flush: true, failOnError: true)







//        category = new Categoria(
//                descripcion: 'Tipo de cliente',
//                multiple: false,
//                required: true)
//        [
//                new Concepto(descripcion: 'Gobierno', costo: 23),
//                new Concepto(descripcion: 'Privado', costo: 2),
//                new Concepto(descripcion: 'Financiero', costo: 3)].each {
//            category.addToConceptos(it)
//        }
//        category.save(flush: true, failOnError: true)

//        println Categoria.list() as JSON
	}
    def destroy = {
    }
}
