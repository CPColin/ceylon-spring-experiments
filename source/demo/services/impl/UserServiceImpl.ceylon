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
    
    shared actual User? findByUserName(String userName) => repository.findByUserName(userName);
    
    shared actual void setPassword(User user, String plainTextPassword)
            => user.encryptedPassword = passwordEncoder.encode(plainTextPassword);
}
