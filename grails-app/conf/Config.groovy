grails.project.groupId = "mx.com.scitum"

grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

grails.converters.json.default.deep = true
grails.views.default.codec = "html"

grails.controllers.defaultScope = 'singleton'

grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml'
            codecs {
                expression = 'html'
                scriptlet = 'html'
                taglib = 'none'
                staticparts = 'none'
            }
        }
    }
}

grails.converters.encoding = "UTF-8"
grails.scaffolding.templates.domainSuffix = 'Instance'

grails.json.legacy.builder = false
grails.enable.native2ascii = true
grails.spring.bean.packages = []
grails.web.disable.multipart=false

grails.exceptionresolver.params.exclude = ['password']

grails.hibernate.cache.queries = false

grails.hibernate.pass.readonly = false
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.logging.jul.usebridge = true
        grails.serverURL = "http://localhost:8080/calculadora"

        grails.plugin.springsecurity.logout.postOnly = false

        log4j = {
            debug 'org.hibernate.SQL'
            trace 'org.hibernate.type'
            info 'org.springframework.security'
        }
        grails.gorm.failOnError = true
    }
    test {
        grails.assets.minifyJs = true
    }

    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

log4j.main = {

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'


}

grails.databinding.dateFormats = ["yyyy-MM-dd'T'hh:mm:ss'Z'", "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"]

angular.pageSize = 25
angular.dateFormat="MM/dd/yyyy"

//Habilitar content-negotiation basado en el header Accept
grails.mime.use.accept.header = true
grails.mime.disable.accept.header.userAgents = []



// Added by the Spring Security Core plugin:
//grails.plugin.springsecurity.userLookup.userDomainClassName = 'mx.com.scitum.auth.User'
//grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'mx.com.scitum.auth.UserRole'
//grails.plugin.springsecurity.authority.className = 'mx.com.scitum.auth.Role'k
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':                ['permitAll'],
	'/index':           ['permitAll'],
	'/index.gsp':       ['permitAll'],
	'/assets/**':       ['permitAll'],
	'/**/js/**':        ['permitAll'],
	'/**/css/**':       ['permitAll'],
	'/**/images/**':    ['permitAll'],
	'/**/favicon.ico':  ['permitAll']
]

//grails.plugin.springsecurity.providerNames = ['ldapAuthProvider', 'anonymousAuthenticationProvider']
grails.plugin.springsecurity.providerNames = ['ldapAuthProvider']


grails.plugin.springsecurity.ldap.context.server = 'ldap://SRVQRO-DC01.mex.scitum.com.mx'
//grails.plugin.springsecurity.ldap.context.managerDn = 'CN=adminsyss,DC=mex,DC=scitum,DC=com,DC=mx'
grails.plugin.springsecurity.ldap.context.managerDn = 'adminsys'
grails.plugin.springsecurity.ldap.context.managerPassword = '53cur3!53cur3'
//grails.plugin.springsecurity.ldap.authorities.retrieveGroupRoles = false
grails.plugin.springsecurity.ldap.authorities.groupSearchBase = 'OU=Scitum Seguridad,DC=mex,DC=scitum,DC=com,DC=mx'
grails.plugin.springsecurity.ldap.search.filter = '(sAMAccountName={0})'
grails.plugin.springsecurity.ldap.search.base = 'OU=Scitum Seguridad,DC=mex,DC=scitum,DC=com,DC=mx'


//grails.plugin.springsecurity.ldap.context.server = 'ldap://ldap.forumsys.com'
//grails.plugin.springsecurity.ldap.context.managerDn = 'cn=read-only-admin,dc=example,dc=com'
//grails.plugin.springsecurity.ldap.context.managerPassword = 'password'
//grails.plugin.springsecurity.ldap.authorities.groupSearchBase = 'ou=mathematicians,dc=example,dc=com'
//grails.plugin.springsecurity.ldap.search.filter = '(sAMAccountName={0})'
//grails.plugin.springsecurity.ldap.search.base = 'dc=example,dc=com'

grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false

grails.plugin.springsecurity.ldap.authorities.retrieveDatabaseRoles = true

