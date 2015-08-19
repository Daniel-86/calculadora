import mx.com.scitum.Categoria
import mx.com.scitum.Concepto
import mx.com.scitum.ConceptoEspecial
import mx.com.scitum.Dependencia
import mx.com.scitum.Factor
import mx.com.scitum.Item
import mx.com.scitum.Propiedad
import mx.com.scitum.Ticket
import mx.com.scitum.auth.Role
import mx.com.scitum.auth.User
import mx.com.scitum.auth.UserRole
import org.apache.commons.logging.LogFactory

import java.util.logging.Logger

class BootStrap {

	def customMarshallerRegistrar

    private static final log = LogFactory.getLog("grails.app.BootStrap")

    def init = { servletContext ->
		customMarshallerRegistrar.registerMarshallers()

        log.debug("Loading categories data")

        Categoria category = new Categoria(
                descripcion: 'Tipo de cliente',
                multiple: false,
                required: true,
                nombre: 'tipo de cliente'
                )
        [
                new Concepto(descripcion: 'Gobierno', costo: 23, nombre: 'gobierno'),
                new Concepto(descripcion: 'Privado', costo: 2, nombre: 'privado'),
                new Concepto(descripcion: 'Financiero', costo: 3, nombre: 'financiero')].each {
            it.setNombre(it.descripcion)
            it.setCustomId(it.descripcion)
            category.addToConceptos(it)
        }
        category.setCustomId('tipo de cliente')
        category.setNombre('tipo de cliente')
        category.save(flush: true, failOnError: true)





        category = new Categoria(
                descripcion: 'Ingeniería en sitio',
                multiple: false,
                required: true, 
                nombre: 'ingenieria_en_sitio')
        [
                new Concepto(descripcion: 'Sí', costo: 1, nombre: 'si'),
                new Concepto(descripcion: 'No', costo: 0, nombre: 'no')].each {
            it.setNombre(it.descripcion)
            it.setCustomId(it.descripcion)
            category.addToConceptos(it)
        }
        category.setNombre(category.descripcion)
        category.setCustomId(category.descripcion)
        def arrPropC2, arrConC2
        ConceptoEspecial ceC2
        def techPropsC2 = {
            def lista = [
                    new Propiedad(descripcion: 'cantidad', tipo: 'int', nombre: 'cantidad')
            ]
            return lista
        }
//        def techConceptsC2 = {
//            new Concepto(descripcion: 'Ingeni')
//        }
        ceC2 = new ConceptoEspecial(descripcion: 'Ingeniero de operaciones', nombre: 'ingeniero de operaciones')
        ceC2.setNombre(ceC2.descripcion)
        ceC2.setCustomId(ceC2.descripcion)
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setNombre('cantidad')
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('ingeniero de operaciones cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'QA', nombre: 'qa')
        ceC2.setNombre(ceC2.descripcion)
        ceC2.setCustomId(ceC2.descripcion)
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setNombre('cantidad')
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('qa cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'Analista', nombre: 'analista')
        ceC2.setNombre(ceC2.descripcion)
        ceC2.setCustomId(ceC2.descripcion)
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setNombre('cantidad')
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('analista cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'Service manager', nombre: 'service manager')
        ceC2.setNombre(ceC2.descripcion)
        ceC2.setCustomId(ceC2.descripcion)
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setNombre('cantidad')
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('service manager cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        ceC2 = new ConceptoEspecial(descripcion: 'CSIRT', nombre: 'csirt')
        ceC2.setNombre(ceC2.descripcion)
        ceC2.setCustomId(ceC2.descripcion)
        arrPropC2 = techPropsC2();
        arrPropC2.find {it.descripcion == 'cantidad'}?.setNombre('cantidad')
        arrPropC2.find {it.descripcion == 'cantidad'}?.setCustomId('csirt cantidad')
        arrPropC2.each { ceC2.addToPropiedades(it)}
        category.addToComponentes(ceC2)

        category.save(flush: true, failOnError: true)




        category = new Categoria(
                descripcion: 'Tecnología',
                multiple: true,
                required: true, 
                nombre: 'tecnología')
        category.setNombre(category.descripcion)
        category.setCustomId(category.descripcion)
        def arrProp, arrCon
        def technologyProps = {
            def lista = [
                new Propiedad(nombre: 'cantidad', descripcion: 'cantidad', tipo: 'Integer'),
                new Propiedad(nombre: 'volumetría', descripcion: 'volumetría')
            ]
            return lista
        }
        def technologyConcepts = {
            def lista = [
                new Concepto(nombre: 'Firewall/NAT', descripcion: 'Firewall/NAT', costo: 23, multiple: true),
                new Concepto(nombre: 'VPN IPSEC', descripcion: 'VPN IPSEC', costo: 2, multiple: true),
                new Concepto(nombre: 'VPN SSL', descripcion: 'VPN SSL', costo: 3, multiple: true),
                new Concepto(nombre: 'IPS', descripcion: 'IPS', costo: 3, multiple: true),
                new Concepto(nombre: 'Application control', descripcion: 'Application control', costo: 3, multiple: true),
                new Concepto(nombre: 'URL filtering', descripcion: 'URL filtering', costo: 3, multiple: true),
                new Concepto(nombre: 'Antivirus', descripcion: 'Antivirus', costo: 123, multiple: true),
                new Concepto(nombre: 'HA', descripcion: 'HA', costo:  23, multiple: true)
            ]
            return lista
        }

        ConceptoEspecial conceptoEspecial = new ConceptoEspecial(descripcion: 'Firewall', nombre: 'firewall')
        conceptoEspecial.setNombre(conceptoEspecial.descripcion)
        conceptoEspecial.setCustomId(conceptoEspecial.descripcion)
        arrProp = technologyProps()
        arrProp.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'IPS', nombre: 'ips')
        conceptoEspecial.setNombre(conceptoEspecial.descripcion)
        conceptoEspecial.setCustomId(conceptoEspecial.descripcion)
        arrProp = technologyProps()
        arrProp.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'Filtrado web', nombre: 'filtrado web')
        conceptoEspecial.setNombre(conceptoEspecial.descripcion)
        conceptoEspecial.setCustomId(conceptoEspecial.descripcion)
        arrProp = technologyProps()
        arrProp.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        conceptoEspecial = new ConceptoEspecial(descripcion: 'Antispam', nombre: 'antispam')
        conceptoEspecial.setNombre(conceptoEspecial.descripcion)
        conceptoEspecial.setCustomId(conceptoEspecial.descripcion)
        arrProp = technologyProps()
        arrProp.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToPropiedades(it)
        }
        arrCon = technologyConcepts()
        arrCon.each {
            it.setNombre(it.descripcion)
            it.setCustomId(conceptoEspecial.nombre+'_'+it.descripcion)
            conceptoEspecial.addToConceptosE(it)
        }
        category.addToComponentes(conceptoEspecial)

        category.save(flush: true, failOnError: true)




        Dependencia dependencia

        Ticket ticket
        ticket = new Ticket(cc: 10, es: 20, acs: 36, rq: 19)
        ticket.setNombre('tickets 1')
        ticket.setCustomId('tickets 1')
        ticket.setDescripcion('Para pruebas')
        ticket.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(3))
        dependencia.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(21))
        dependencia.save(flush: true)

        ticket = new Ticket(cc: 54, es: 42, acs: 33, rq: 0)
        ticket.setNombre('tickets 2')
        ticket.setCustomId('tickets 2')
        ticket.setDescripcion('Para pruebas')
        ticket.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(48))
        dependencia.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(47))
        dependencia.save(flush: true)

        ticket = new Ticket(cc: 29, es: 34, acs: 98, rq: 0, nombre: 'miticket', descripcion: 'para pruebas')
        ticket.setNombre('mi ticket')
        ticket.setCustomId('mi ticket')
        ticket.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(3))
        dependencia.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(9))
        dependencia.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(21))
        dependencia.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(22))
        dependencia.save(flush: true)
        dependencia = new Dependencia(rule: ticket, item: Item.get(43))
        dependencia.save(flush: true)

        Factor factor
        factor = new Factor(nombre: 'Firewall con HA', descripcion: 'Firewall con alta disponibilidad', factor: 0.05)
        factor.setNombre('Firewall con HA')
        factor.setCustomId('Firewall con HA')
        factor.save(flush: true)
        dependencia = new Dependencia(rule: factor, item: Item.get(27))
        dependencia.save(flush: true)

        factor = new Factor(nombre: 'qa 5', descripcion: 'despues de 5 qa disminuye 0.03 por cada qa extra',
                factor:-0.03, lowerLimit: 5, step: 3)
        factor.setNombre('qa 5')
        factor.setCustomId('qa 5')
        factor.save(flush: true)
        dependencia = new Dependencia(rule: factor, item: Item.get(9), lowerLimit: 5)
        dependencia.save(flush: true)

        factor = new Factor(nombre: 'web appcontrol', descripcion: 'web con app control', factor: 0.35, step: 1)
        factor.setNombre('web appcontrol')
        factor.setCustomId('web appcontrol')
        factor.save(flush: true)
        dependencia = new Dependencia(rule: factor, item: Item.get(46))
        dependencia.save(flush: true)



        factor = new Factor(nombre: 'web appcontrol', descripcion: 'web con app control', factor: 0.05, step: 1)
        factor.setNombre('web appcontrol')
        factor.setCustomId('web appcontrol1')
        factor.save(flush: true)
        dependencia = new Dependencia(rule: factor, item: Item.get(46), lowerLimit: 3, upperLimit: 9, step: 2)
        dependencia.save(flush: true)



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

        Role role
        if(!Role.findByAuthority('ROLE_GOD')) {
            log.debug("Agregando el rol 'ROLE_GOD'")
            role = new Role('ROLE_GOD')
            role.save(flush: true)
        }
        if(!Role.findByAuthority('ROLE_ADMIN')) {
            log.debug("Agregando el rol 'ROLE_ADMIN'")
            role = new Role('ROLE_ADMIN')
            role.save(flush: true)
        }
        if(!Role.findByAuthority('ROLE_USER')) {
            log.debug("Agregando el rol 'ROLE_USER'")
            role = new Role('ROLE_USER')
            role.save(flush: true)
        }

        User user
        UserRole userRole
        if(!User.findByUsername('daniel.jimenez')) {
            log.debug("Agregando el usuario 'daniel.jimenez' con rol 'ROLE_GOD'")
            user = new User('daniel.jimenez', 'asdf')
            user.save(flush: true)
            role = Role.findByAuthority('ROLE_GOD')
            userRole = new UserRole(user, role)
            userRole.save(flush: true)
        }

        if(!User.findByUsername('edgar.bravo')) {
            log.debug("Agregando el usuario 'edgar.bravo' con rol 'ROLE_USER'")
            user = new User('edgar.bravo', 'asdf')
            user.save(flush: true)
            role = Role.findByAuthority('ROLE_USER')
            userRole = new UserRole(user, role)
            userRole.save(flush: true)
        }

        if(!User.findByUsername('jcarsi')) {
            log.debug("Agregando el usuario 'jcarsi' con rol 'ROLE_ADMIN'")
            user = new User('jcarsi', 'asdf')
            user.save(flush: true)
            role = Role.findByAuthority('ROLE_ADMIN')
            userRole = new UserRole(user, role)
            userRole.save(flush: true)
        }

        if(!User.findByUsername('abraham.aguilar')) {
            log.debug("Agregando el usuario 'abraham.aguilar' con rol 'ROLE_GOD'")
            user = new User('abraham.aguilar', 'asdf')
            user.save(flush: true)
            role = Role.findByAuthority('ROLE_GOD')
            userRole = new UserRole(user, role)
            userRole.save(flush: true)
        }

        if(!User.findByUsername('luis.bravo')) {
            log.debug("Agregando el usuario 'luis.bravo' con rol 'ROLE_ADMIN'")
            user = new User('luis.bravo', 'asdf')
            user.save(flush: true)
            role = Role.findByAuthority('ROLE_ADMIN')
            userRole = new UserRole(user, role)
            userRole.save(flush: true)
        }

        if(!User.findByUsername('luis.valle')) {
            log.debug("Agregando el usuario 'luis.valle' con rol 'ROLE_ADMIN'")
            user = new User('luis.valle', 'asdf')
            user.save(flush: true)
            role = Role.findByAuthority('ROLE_ADMIN')
            userRole = new UserRole(user, role)
            userRole.save(flush: true)
        }


	}
    def destroy = {
    }
}
