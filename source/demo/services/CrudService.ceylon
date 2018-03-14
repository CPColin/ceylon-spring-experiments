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
    
    shared formal void save(Type entity);
}
