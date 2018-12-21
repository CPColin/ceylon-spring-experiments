import javax.persistence {
    entity
}

import org.springframework.security.core {
    GrantedAuthority
}

entity
shared class Authority(
    shared String name = "")
        extends Entity() satisfies GrantedAuthority {
    authority => name;
    
    string => authority;
}
