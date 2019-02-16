import ceylon.time {
    Instant,
    now
}

import javax.persistence {
    column,
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
    
    column { updatable = false; }
    shared late Instant? dateCreated;
    
    shared late Instant? lastUpdated;
    
    "Indicates `true` if this entity has ever been saved to the database; that is, when its ID is not null or zero."
    shared Boolean saved => if (exists id) then id != 0 else false;
    
    preUpdate
    prePersist
    shared void updateTimeStamps() {
        value instant = now();
        
        lastUpdated = instant;
        
        if (!saved && !dateCreated exists) {
            dateCreated = instant;
        }
    }
}
