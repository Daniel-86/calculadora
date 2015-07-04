import mx.com.scitum.Categoria
import mx.com.scitum.Concepto
import mx.com.scitum.ConceptoEspecial
import mx.com.scitum.Item
import mx.com.scitum.Propiedad
import mx.com.scitum.Ticket

class BootStrap {

	def customMarshallerRegistrar

    def init = { servletContext ->
		customMarshallerRegistrar.registerMarshallers()

        println "loading categories data"

        Categoria category = new Categoria(
                descripcion: 'Tipo de cliente',
                multiple: false,
                required: true,
                customId: 'tipo_de_cliente'
                )
        [
                new Concepto(descripcion: 'Gobierno', costo: 23, customId: 'gobierno'),
                new Concepto(descripcion: 'Privado', costo: 2, customId: 'privado'),
                new Concepto(descripcion: 'Financiero', costo: 3, customId: 'financiero')].each {
            category.addToConceptos(it)
        }
        category.save(flush: true, failOnError: true)





        category = new Categoria(
                descripcion: 'Ingeniería en sitio',
                multiple: false,
                required: true, 
                customId: 'ingenieria_en_sitio')
        [
                new Concepto(descripcion: 'Sí', costo: 1, customId: 'si'),
                new Concepto(descripcion: 'No', costo: 0, customId: 'no')].each {
            category.addToConceptos(it)
        }
        def arrPropC2, arrConC2
        ConceptoEspecial ceC2
        def techPropsC2 = {
            def lista = [
                    new Propiedad(descripcion: 'cantidad', tipo: 'int')
            ]
            return lista
        }
//        def techConceptsC2 = {
//            new Concepto(descripcion: 'Ingeni')
//        }
        ceC2 = new ConceptoEspecial(descripcion: 'Ingeniero de operaciones', customId: 'ingeniero_de_operaciones')
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('ingeniero_de_operaciones_cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'QA', customId: 'qa')
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('qa_cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'Analista', customId: 'analista')
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('analista_cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'Service manager', customId: 'service_manager')
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('service_manager_cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'CSIRT', customId: 'csirt')
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('csirt_cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        category.save(flush: true, failOnError: true)




        category = new Categoria(
                descripcion: 'Tecnología',
                multiple: true,
                required: true, 
                customId: 'tecnologia')
        def arrProp, arrCon
        def technologyProps = {
            def lista = [
                new Propiedad(descripcion: 'cantidad', tipo: 'Integer'),
                new Propiedad(descripcion: 'volumetría')
            ]
            return lista
        }
        def technologyConcepts = {
            def lista = [
                new Concepto(descripcion: 'Firewall/NAT', costo: 23, multiple: true),
                new Concepto(descripcion: 'VPN IPSEC', costo: 2, multiple: true),
                new Concepto(descripcion: 'VPN SSL', costo: 3, multiple: true),
                new Concepto(descripcion: 'IPS', costo: 3, multiple: true),
                new Concepto(descripcion: 'Application control', costo: 3, multiple: true),
                new Concepto(descripcion: 'URL filtering', costo: 3, multiple: true),
                new Concepto(descripcion: 'Antivirus', costo: 123, multiple: true),
                new Concepto(descripcion: 'HA', costo:  23, multiple: true)
            ]
            return lista
        }

        ConceptoEspecial conceptoEspecial = new ConceptoEspecial(descripcion: 'Firewall', customId: 'firewall')
        arrProp = technologyProps()
        arrProp.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'IPS', customId: 'ips')
        arrProp = technologyProps()
        arrProp.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'Filtrado web', customId: 'filtrado_web')
        arrProp = technologyProps()
        arrProp.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'Antispam', customId: 'antispam')
        arrProp = technologyProps()
        arrProp.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setCustomId(conceptoEspecial.customId+'_'+it.descripcion.toLowerCase().replaceAll(' ', '_'))
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        category.save(flush: true, failOnError: true)





        Ticket ticket
        ticket = new Ticket(cc: 1, es: 2, acs: 3, rq: 1)
        ticket.addToDependencias(Item.get(1))
        ticket.addToDependencias(Item.get(2))
        ticket.save(flush: true)

        ticket = new Ticket(cc: 1, es: 2, acs: 3, rq: 1)
        ticket.save(flush: true)


//        Ticket tickets = new Ticket(idsString: 'gobierno, firewall_firewall/nat', cc: 20, es: 10, acs: 5, rq: 15)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat', cc: 50, es: 80, acs: 0,
//                rq: 0)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat, firewall_ips', cc: 270,
//                es: 80, acs: 250, rq: 0)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat, firewall_ips, firewall_filtrado-web,  ' +
//                'firewall_application-' +
//                'control', cc: 300, es: 120,
//                acs: 250, rq: 0)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat, firewall_ips, ' +
//                'firewall_application-control', cc: 280,
//                es: 80, acs: 250, rq: 0)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat, firewall_ips, firewall_filtrado-web', cc:
//                280, es: 80,
//                acs: 250, rq: 0)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat, firewall_application-control', cc:
//                270, es: 80,
//                acs: 0, rq: 0)
//        tickets.save(flush: true, failOnError: true)
//        tickets = new Ticket(idsString: 'gobierno, sitio, datacenter, firewall_firewall/nat, firewall_filtrado-web',
//                cc: 270, es: 80,
//                acs: 0, rq: 0)
//        tickets.save(flush: true, failOnError: true)
	}
    def destroy = {
    }
}
