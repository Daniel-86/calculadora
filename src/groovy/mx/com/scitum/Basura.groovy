package mx.com.scitum

import org.springframework.ldap.core.DirContextOperations
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.ldap.userdetails.LdapAuthoritiesPopulator

/**
 * Created by daniel.jimenez on 08/07/2015.
 */
class Basura implements LdapAuthoritiesPopulator {
    @Override
    Collection<? extends GrantedAuthority> getGrantedAuthorities(DirContextOperations dirContextOperations, String s) {
        return null
    }
}
