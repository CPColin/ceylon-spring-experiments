import demo.domain {
    User
}
import demo.repositories {
    UserRepository
}
import demo.services {
    EncryptionService,
    UserService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
shared class UserServiceImpl() extends CrudServiceImpl<User>() satisfies UserService {
    autowired
    shared actual late UserRepository repository;
    
    autowired
    shared late EncryptionService encryptionService;
    
    shared actual User? findByUserName(String userName) => repository.findByUserName(userName);
}
