import ceylon.test {
    assertEquals,
    parameters,
    test
}

import demo.domain {
    Entity
}

[[Integer, Boolean]*] savedParameters = [
    [0, false],
    [1, true],
    [2, true]
];

shared class EntityTests() {
    test
    parameters(`value savedParameters`)
    shared void testSaved(Integer id, Boolean expected) {
        object entity extends Entity() {}
        
        entity.id = id;
        
        assertEquals(entity.saved, expected, "Entity.saved value does not match expected value.");
    }
}
