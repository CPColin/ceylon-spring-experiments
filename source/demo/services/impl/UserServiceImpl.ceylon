import demo.domain {
    User
}
import demo.repositories {
    UserRepository
}
import demo.services {
    UserService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.security.core.userdetails {
    UserDetails,
    UsernameNotFoundException
}
import org.springframework.security.crypto.password {
    PasswordEncoder
}
import org.springframework.stereotype {
    service
}

service
shared class UserServiceImpl() extends CrudServiceImpl<User>() satisfies UserService {
    autowired
    shared actual late UserRepository repository;
    
    autowired
    shared late PasswordEncoder passwordEncoder;
    
    shared actual String encryptPassword(String plainTextPassword)
            => passwordEncoder.encode(plainTextPassword);
    
    shared actual User? findByUsername(String username) => repository.findByUsername(username);
    
    throws (`class UsernameNotFoundException`, "when no user matches the given name")
    shared actual UserDetails loadUserByUsername(String username) {
        if (exists user = findByUsername(username)) {
            return user;
        }
        
        throw UsernameNotFoundException("User not found: ``username``");
    }
}
