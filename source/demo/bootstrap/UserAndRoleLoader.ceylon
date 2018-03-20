import demo.domain {
    Authority,
    User
}
import demo.services {
    AuthorityService,
    UserService
}

import org.apache.logging.log4j {
    LogManager
}
import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.context {
    ApplicationListener
}
import org.springframework.context.event {
    ContextRefreshedEvent
}
import org.springframework.stereotype {
    component
}

component
class UserAndRoleLoader() satisfies ApplicationListener<ContextRefreshedEvent> {
    autowired late AuthorityService authorityService;
    
    autowired late UserService userService;
    
    value log = LogManager.getLogger(`UserAndRoleLoader`);
    
    shared actual void onApplicationEvent(ContextRefreshedEvent event) {
        value admin = createAuthority("ROLE_ADMIN");
        value user = createAuthority("ROLE_USER");
        
        createUsers("admin", 2, admin, user);
        createUsers("user", 5, user);
    }
    
    Authority createAuthority(String authorityName) {
        value authority = Authority();
        
        authority.authority = authorityName;
        
        authorityService.save(authority);
        
        log.info("Created authority ``authorityName``");
        
        return authority;
    }
    
    void createUsers(String usernamePrefix, Integer count, Authority* authorities) {
        for (id in 1..count) {
            value user = User();
            value username = "``usernamePrefix````id``";
            
            user.username = username;
            userService.setPassword(user, username);
            
            for (authority in authorities) {
                user.authorities.add(authority);
            }
            
            userService.save(user);
            
            log.info("Created user ``username``");
        }
    }
}
