import javax.persistence {
    entity,
    generatedValue,
    id
}

entity
shared class User(name) {
    id
    generatedValue
    shared late Integer id;
    
    shared String name;
    
    string => "``id``: ``name``";
}
