import demo.domain {
    Entity
}

import java.lang {
    JIterable=Iterable
}

shared interface CrudService<Type>
        given Type satisfies Entity {
    shared formal void delete(Integer id);
    
    shared formal JIterable<Type> getAll();
    
    shared formal Type? getById(Integer id);
    
    // FIXME: This should return Type, but doing so makes Spring think CrudServiceImpl.save() doesn't match.
    shared formal Entity save(Type entity);
}
