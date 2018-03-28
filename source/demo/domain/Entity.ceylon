import java.util {
    Date
}

import javax.persistence {
    generatedValue,
    id,
    mappedSuperclass,
    prePersist,
    preUpdate,
    version
}

mappedSuperclass
shared abstract class Entity() {
    id
    generatedValue
    shared late Integer? id;
    
    version
    shared late Integer? version;
    
    shared variable Date? dateCreated = null;
    
    shared variable Date? lastUpdated = null;
    
    "Indicates `true` if this entity has ever been saved to the database; that is, when its ID is not null or zero."
    shared Boolean saved => if (exists id) then id != 0 else false;
    
    preUpdate
    prePersist
    shared void updateTimeStamps() {
        value instant = Date();
        
        lastUpdated = instant;
        
        if (!dateCreated exists) {
            dateCreated = instant;
        }
    }
}
