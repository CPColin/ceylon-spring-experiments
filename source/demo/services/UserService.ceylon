import demo.domain {
    User
}

import org.springframework.security.core.userdetails {
    UserDetails,
    UserDetailsService,
    UsernameNotFoundException
}

shared interface UserService satisfies CrudService<User> & UserDetailsService {
    shared formal User? findByUsername(String username);
    
    shared formal void setPassword(User user, String plainTextPassword);
    
    throws (`class UsernameNotFoundException`, "when no user matches the given name")
    shared actual UserDetails loadUserByUsername(String username) {
        if (exists user = findByUsername(username)) {
            return user;
        }
        
        throw UsernameNotFoundException("User not found: ``username``");
    }
}
