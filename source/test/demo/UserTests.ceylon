import ceylon.test {
	test
}

import demo.domain {
	User
}
import demo.repositories {
	UserRepository
}

import org.springframework.beans.factory.annotation {
	autowired
}
import org.springframework.transaction.annotation {
	transactional
}

transactional
shared class UserTests() {
    autowired late UserRepository userRepository;
    
    test
    shared void testSave() {
        value user = User("somebody");
        
        userRepository.save(user);
    }
    
    test
    shared void testSaveAgain() {
        value user = User("somebody else");
        
        userRepository.save(user);
    }
    
    test
    shared void testSomethingElse() {
        print(userRepository.findAll());
    }
}

transactional
shared class UserTests2() {
	autowired late UserRepository userRepository;
	
	test
	shared void testSave() {
		value user = User("nobody");
		
		userRepository.save(user);
	}
	
	test
	shared void testSomethingElse() {
		print(userRepository.findAll());
	}
}
