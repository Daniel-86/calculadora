import grails.util.Environment

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

def basePathExtraConfigs = userHome
environments {
    development {
        grails.logging.jul.usebridge = true

        log4j = {
            appenders {
                file name: 'sqlLog', file: 'target/sql.log', maxFileSize: 1024
                file name: 'springSecurity', file: 'target/sringsecurity.log'
            }
            debug sqlLog:'org.hibernate.SQL', additivity: false
            trace sqlLog:'org.hibernate.type', additivity: false
            info springSecurity:'org.springframework.security', additivity: false
        }
        grails.gorm.failOnError = true
    }
    test {
        grails.assets.minifyJs = true
    }

    production {
        grails.logging.jul.usebridge = false
        if(basePathExtraConfigs.contains('tomcat')) {basePathExtraConfigs = '/home/sistemas';}
    }
}

String extraConfigFile = System.properties['os.name'].toLowerCase().contains('windows')? "file:${basePathExtraConfigs}\\${appName}-${Environment.current.name}-config.groovy": "file:${basePathExtraConfigs}/${appName}-${Environment.current.name}-config.groovy"
grails.config.locations = [
        extraConfigFile
]
//        grails.config.locations = {
//            "file:C:\\Users\\daniel.jimenez\\calculadora-development-config.groovy"
//        }

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
grails.plugin.springsecurity.userLookup.userDomainClassName = 'mx.com.scitum.auth.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'mx.com.scitum.auth.UserRole'
grails.plugin.springsecurity.authority.className = 'mx.com.scitum.auth.Role'
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

grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false

grails.plugin.springsecurity.ldap.authorities.retrieveDatabaseRoles = true

grails.plugin.springsecurity.roleHierarchy = '''
   ROLE_GOD > ROLE_ADMIN
   ROLE_ADMIN > ROLE_USER
'''

grails.plugin.springsecurity.filterChain.chainMap = [
        '/**': 'JOINED_FILTERS,-exceptionTranslationFilter,-authenticationProcessingFilter,-securityContextPersistenceFilter,-rememberMeAuthenticationFilter'
]

grails.plugin.springsecurity.rest.login.useJsonCredentials = true
grails.plugin.springsecurity.rest.login.failureStatusCode = 401
//grails.plugin.springsecurity.rest.token.storage.useGorm = true
//grails.plugin.springsecurity.rest.token.storage.gorm.tokenDomainClassName = 'mx.com.scitum.auth.AuthenticationToken'
//grails.plugin.springsecurity.rest.token.storage.gorm.tokenValuePropertyName = 'token'
//grails.plugin.springsecurity.rest.token.storage.gorm.usernamePropertyName = 'username'

cors.headers = [
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': true,
        'Access-Control-Allow-Headers': 'origin, authorization, accept, content-type, x-requested-with, x-auth-token',
        'Access-Control-Allow-Methods': 'GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS',
        'Access-Control-Max-Age': 3600
]

