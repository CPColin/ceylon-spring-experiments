import ceylon.test {
    assertEquals,
    assertNotEquals,
    test
}

import demo.domain {
    User
}
import demo.services.impl {
    UserServiceImpl
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.transaction.annotation {
    transactional
}

transactional
shared class UserServiceImplTests() {
    autowired late UserServiceImpl service;
    
    test
    shared void testIdIsPopulatedAfterSave() {
        value user = User();
        
        user.userName = "test";
        
        assertEquals(user.id, 0);
        service.save(user);
        assertNotEquals(user.id, 0);
    }
}
