import java.util {
    ArrayList,
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
shared class User() extends Entity() satisfies UserDetails {
    column { unique = true; }
    shared actual variable String username = "";
    
    shared actual variable String password = "";
    
    shared actual variable Boolean enabled = true;
    
    manyToMany { fetch = FetchType.eager; }
    shared variable JList<Role> roles = ArrayList<Role>();
    
    transient
    shared actual variable JList<GrantedAuthority> authorities = ArrayList<GrantedAuthority>();
    
    transient
    shared actual Boolean accountNonExpired = true;
    
    transient
    shared actual Boolean accountNonLocked = true;
    
    transient
    shared actual Boolean credentialsNonExpired = true;
}
