import org.springframework.security.core.userdetails {
    UserDetails
}
import java.util {
    Collection
}
import org.springframework.security.core {
    GrantedAuthority
}

class UserDetailsImpl() satisfies UserDetails {
    shared actual Boolean accountNonExpired => nothing;
    
    shared actual Boolean accountNonLocked => nothing;
    
    shared actual Collection<out GrantedAuthority> authorities => nothing;
    
    shared actual Boolean credentialsNonExpired => nothing;
    
    shared actual variable Boolean enabled = true;
    
    shared actual String password => nothing;
    
    shared actual String username => nothing;
    
}
