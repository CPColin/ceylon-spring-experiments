import java.util {
    ArrayList,
    JList=List
}

import javax.persistence {
    FetchType,
    column,
    entity,
    joinColumn,
    joinTable,
    manyToMany,
    table
}

entity
table { name = "Users"; }
shared class User() extends Entity() {
    column { name = "Username"; }
    shared variable String userName = "";
    
    column { name = "Password"; }
    shared variable String encryptedPassword = "";
    
    shared variable Boolean enabled = true;
    
    // TODO: This is a little tortured, but it works, for now. A custom schema might be cleaner.
    manyToMany { fetch = FetchType.eager; }
    joinTable {
        name = "Authorities";
        joinColumns = [
            joinColumn { name = "Username"; referencedColumnName = "Username"; }
        ];
        inverseJoinColumns = [
            joinColumn { name = "Authority"; referencedColumnName = "Authority"; }
        ];
    }
    shared variable JList<Authority> authorities = ArrayList<Authority>();
}
