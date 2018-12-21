import ceylon.test {
    assertFalse,
    assertTrue,
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
        variable value user = User {
            username = "test";
        };
        
        assertFalse(user.id exists);
        user = userServiceImpl.save(user);
        assertTrue(user.id exists);
    }
}
