import java.util {
    JList=List,
    ArrayList
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
shared class Role() extends Entity() satisfies GrantedAuthority {
    shared variable String name = "";
    
    manyToMany { fetch = FetchType.eager; }
    shared variable JList<Authority> authorities = ArrayList<Authority>();
    
    shared actual String authority => "ROLE_``name``";
    
    string => authority;
}
