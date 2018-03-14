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
    shared late Integer id;
    
    version
    shared late Integer version;
    
    shared variable Date? dateCreated = null;
    
    shared variable Date? lastUpdated = null;
    
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
