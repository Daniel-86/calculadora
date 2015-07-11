package mx.com.scitum.auth

import org.springframework.ldap.core.DirContextAdapter
import org.springframework.ldap.core.DirContextOperations
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper

/**
 * Created by daniel.jimenez on 09/07/2015.
 */
class ADUserDetailsContextMapper implements UserDetailsContextMapper {
    @Override
    UserDetails mapUserFromContext(DirContextOperations dirContextOperations, String s, Collection<? extends GrantedAuthority> collection) {
        return null
    }

    @Override
    void mapUserToContext(UserDetails userDetails, DirContextAdapter dirContextAdapter) {

    }
}
