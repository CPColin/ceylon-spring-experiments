import demo.domain {
    User
}

import org.springframework.security.core.userdetails {
    UserDetailsService
}

shared interface UserService satisfies CrudService<User> & UserDetailsService {
    shared formal String encryptPassword(String plainTextPassword);
    
    shared formal User? findByUsername(String username);
}
