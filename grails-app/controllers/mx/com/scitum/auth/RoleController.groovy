package mx.com.scitum.auth

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_GOD'])
class RoleController extends grails.plugin.springsecurity.ui.RoleController {
}
