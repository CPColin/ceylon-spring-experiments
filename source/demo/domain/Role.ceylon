import javax.persistence {
    FetchType,
    entity,
    manyToMany
}

import org.springframework.security.core {
    GrantedAuthority
}

entity
shared class Role(
    shared String name = "",
    manyToMany { fetch = FetchType.eager; }
    shared variable Set<Authority> authorities = emptySet)
        extends Entity() satisfies GrantedAuthority {
    shared actual String authority => "ROLE_``name``";
    
    string => authority;
}
