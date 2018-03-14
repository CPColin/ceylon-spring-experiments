import demo.domain {
    Entity
}
import demo.services {
    CrudService
}
import demo.util {
    CeylonRepository
}

import java.lang {
    JIterable=Iterable
}

shared abstract class CrudServiceImpl<Type>()
        satisfies CrudService<Type>
        given Type satisfies Entity {
    shared formal CeylonRepository<Type,Integer> repository;
    
    shared actual default void delete(Integer id) => repository.deleteById(id);
    
    shared actual default JIterable<Type> getAll() => repository.findAll();
    
    shared actual default Type? getById(Integer id)
            => let (entity = repository.findById(id))
                if (entity.present) then entity.get() else null;
    
    shared actual default void save(Type entity) => repository.save(entity);
}
