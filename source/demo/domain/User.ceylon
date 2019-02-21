import ceylon.interop.java {
    JavaSet
}

import java.util {
    JSet=Set
}

import javax.persistence {
    FetchType,
    column,
    entity,
    manyToMany,
    transient
}

import org.springframework.security.core {
    GrantedAuthority
}
import org.springframework.security.core.userdetails {
    UserDetails
}

entity
shared class User(
    column { unique = true; }
    shared actual String username = "",
    shared actual String password = "",
    shared actual Boolean enabled = true,
    manyToMany { fetch = FetchType.eager; }
    shared Set<Role> roles = emptySet)
        extends Entity() satisfies UserDetails {
    transient
    variable JSet<GrantedAuthority>? _authorities = null;
    
    shared actual JSet<GrantedAuthority> authorities
            => _authorities else (_authorities = JavaSet<GrantedAuthority>(set(concatenate(
                    roles,
                    {
                        for (role in roles)
                            for (authority in role.authorities)
                                authority
                    }
                ))));
    
    transient
    shared actual Boolean accountNonExpired = true;
    
    transient
    shared actual Boolean accountNonLocked = true;
    
    transient
    shared actual Boolean credentialsNonExpired = true;
}
