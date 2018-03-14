import java.util {
    ArrayList,
    JList=List
}

import javax.persistence {
    FetchType,
    entity,
    joinTable,
    manyToMany
}

entity
shared class Role() extends Entity() {
    shared variable String role = "";
    
    manyToMany { fetch = FetchType.eager; }
    joinTable
    shared variable JList<User> users = ArrayList<User>();
}
