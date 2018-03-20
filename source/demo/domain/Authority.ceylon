import javax.persistence {
    entity
}

import org.springframework.security.core {
    GrantedAuthority
}

entity
shared class Authority() extends Entity() satisfies GrantedAuthority {
    shared variable String name = "";
    
    shared actual String authority => name;
    
    string => authority;
}
