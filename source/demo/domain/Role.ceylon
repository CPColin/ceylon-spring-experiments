import java.util {
    Collections,
    JList=List
}

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
    shared variable JList<Authority> authorities = Collections.emptyList<Authority>())
        extends Entity() satisfies GrantedAuthority {
    shared actual String authority => "ROLE_``name``";
    
    string => authority;
}
