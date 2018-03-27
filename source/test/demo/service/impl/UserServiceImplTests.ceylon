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
    autowired late UserServiceImpl userServiceImpl;
    
    test
    shared void testIdIsPopulatedAfterSave() {
        variable value user = User();
        
        user.username = "test";
        
        assertEquals(user.id, 0);
        user = userServiceImpl.save(user);
        assertNotEquals(user.id, 0);
    }
}
