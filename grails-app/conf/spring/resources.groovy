// Place your Spring DSL code here
import mx.com.scitum.CustomMarshallerRegistrar

beans = {
    customMarshallerRegistrar(CustomMarshallerRegistrar)

//    ldapAuthenticator(org.springframework.security.ldap.authentication.BindAuthenticator, ref("contextSource")) {
//        userDnPatterns = ['uid={0},OU=Scitum Seguridad,DC=mex,DC=scitum,DC=com,DC=mx']
//    }

    ldapAuthenticationProvider(org.springframework.security.ldap.authentication.LdapAuthenticationProvider,
            ref("ldapAuthenticator"),
            ref("authoritiesPopulator"))

    authoritiesPopulator(mx.com.scitum.auth.CustomLdapAuthoritiesPopulator)
}
