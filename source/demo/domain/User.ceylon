import java.util {
    ArrayList,
    JList=List
}

import javax.persistence {
    FetchType,
    entity,
    joinTable,
    manyToMany,
    transient
}

entity
shared class User() extends Entity() {
    shared variable String userName = "";
    
    transient shared variable String password = "";
    
    shared variable String encryptedPassword = "";
    
    shared variable Boolean enabled = true;
    
    manyToMany { fetch = FetchType.eager; }
    joinTable
    shared variable JList<Authority> authorities = ArrayList<Authority>();
    
    shared variable Integer failedLoginAttempts = 0;
}
