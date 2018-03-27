import java.lang {
    overloaded,
    JIterable=Iterable
}
import java.util {
    JList=List,
    Optional
}

import org.springframework.data.domain {
    Example,
    Page,
    Pageable,
    Sort
}
import org.springframework.data.jpa.repository {
    JpaRepository
}
import org.springframework.data.repository {
    noRepositoryBean
}

noRepositoryBean
shared interface CeylonRepository<Entity, Id>
        satisfies JpaRepository<Entity, Id>
        given Entity satisfies Object
        given Id satisfies Object {
    shared actual formal Integer count<ConcreteEntity>(Example<ConcreteEntity> example)
            given ConcreteEntity satisfies Entity;
    
    shared actual formal void delete(Entity entity);
    
    overloaded
    shared actual formal void deleteAll();
    
    overloaded
    shared actual formal void deleteAll(JIterable<out Entity> entities);
    
    shared actual formal void deleteAllInBatch();
    
    shared actual formal void deleteById(Id id);
    
    shared actual formal void deleteInBatch(JIterable<Entity> entities);
    
    shared actual formal Boolean \iexists<ConcreteEntity>(Example<ConcreteEntity> example)
            given ConcreteEntity satisfies Entity;
    
    shared actual formal Boolean existsById(Id id);
    
    overloaded
    shared actual formal JList<Entity> findAll();
    
    overloaded
    shared actual formal JList<ConcreteEntity> findAll<ConcreteEntity>(Example<ConcreteEntity> example)
            given ConcreteEntity satisfies Entity;
    
    overloaded
    shared actual formal Page<ConcreteEntity> findAll<ConcreteEntity>(Example<ConcreteEntity> example, Pageable pageable)
            given ConcreteEntity satisfies Entity;
    
    overloaded
    shared actual formal JList<ConcreteEntity> findAll<ConcreteEntity>(Example<ConcreteEntity> example, Sort sort)
            given ConcreteEntity satisfies Entity;
    
    overloaded
    shared actual formal Page<Entity> findAll(Pageable pageable);
    
    overloaded
    shared actual formal JList<Entity> findAll(Sort sort);
    
    shared actual formal JList<Entity> findAllById(JIterable<Id> ids);
    
    shared actual formal Optional<Entity> findById(Id id);
    
    shared actual formal Optional<ConcreteEntity> findOne<ConcreteEntity>(Example<ConcreteEntity> example)
            given ConcreteEntity satisfies Entity;
    
    shared actual formal void flush();
    
    shared actual formal Entity getOne(Id id);
    
    // TODO: Parameter type should not be optional.
    shared actual formal ConcreteEntity save<ConcreteEntity>(ConcreteEntity? entity)
            given ConcreteEntity satisfies Entity;
    
    shared actual formal JList<ConcreteEntity> saveAll<ConcreteEntity>(JIterable<ConcreteEntity> entities)
            given ConcreteEntity satisfies Entity;
    
    // TODO: Parameter type should not be optional.
    shared actual formal ConcreteEntity saveAndFlush<ConcreteEntity>(ConcreteEntity? entity)
            given ConcreteEntity satisfies Entity;
}
