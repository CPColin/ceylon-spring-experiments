import java.util {
    ArrayList,
    JList=List
}

import javax.persistence {
    column,
    entity,
    transient
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
    
    // TODO: many-to-many mapping to Roles, which many-to-many map to Authorities
    transient
    shared actual variable JList<Authority> authorities = ArrayList<Authority>();
    
    transient
    shared actual Boolean accountNonExpired = true;
    
    transient
    shared actual Boolean accountNonLocked = true;
    
    transient
    shared actual Boolean credentialsNonExpired = true;
}
