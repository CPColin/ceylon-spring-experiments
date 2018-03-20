import demo.domain {
    User
}

import org.springframework.security.core.userdetails {
    UserDetailsService
}

shared interface UserService satisfies CrudService<User> & UserDetailsService {
    shared formal User? findByUsername(String username);
    
    shared formal void setPassword(User user, String plainTextPassword);
}
