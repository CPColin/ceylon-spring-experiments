import ceylon.interop.java {
    CeylonIterable,
    JavaList
}

import java.util {
    Collections,
    JList=List
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
    shared JList<Role> roles = Collections.emptyList<Role>())
        extends Entity() satisfies UserDetails {
    transient
    variable JList<GrantedAuthority>? _authorities = null;
    
    shared actual JList<GrantedAuthority> authorities
            => _authorities else (_authorities = JavaList<GrantedAuthority>(concatenate(
                    CeylonIterable(roles),
                    {
                        for (role in roles)
                            for (authority in role.authorities)
                                authority
                    }
                )));
    
    transient
    shared actual Boolean accountNonExpired = true;
    
    transient
    shared actual Boolean accountNonLocked = true;
    
    transient
    shared actual Boolean credentialsNonExpired = true;
}
