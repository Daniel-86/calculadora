package mx.com.scitum.auth

import org.springframework.ldap.core.DirContextOperations
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.ldap.userdetails.LdapAuthoritiesPopulator

/**
 * Created by daniel.jimenez on 13/07/2015.
 */
class CustomLdapAuthoritiesPopulator implements LdapAuthoritiesPopulator {
    @Override
    Collection<? extends GrantedAuthority> getGrantedAuthorities(DirContextOperations dirContextOperations, String s) {
        Collection<GrantedAuthority> gas = new HashSet<GrantedAuthority>()
        def user = User.findByUsername(s)
        List<UserRole> inDBAuth = UserRole.findAllByUser(user)
        inDBAuth?.each {ur-> gas.add(new SimpleGrantedAuthority(ur.role?.authority))}
        return gas
    }
}
