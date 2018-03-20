import ceylon.interop.java {
    JavaList
}

import demo.domain {
    Authority,
    Role,
    User
}
import demo.services {
    AuthorityService,
    RoleService,
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
    
    autowired late RoleService roleService;
    
    autowired late UserService userService;
    
    value log = LogManager.getLogger(`UserAndRoleLoader`);
    
    shared actual void onApplicationEvent(ContextRefreshedEvent event) {
        value manageProducts = createAuthority("MANAGE_PRODUCTS");
        value viewProductDetails = createAuthority("VIEW_PRODUCT_DETAILS");
        value adminRole = createRole("ADMIN", manageProducts);
        value userRole = createRole("USER", viewProductDetails);
        
        createUsers("admin", 2, adminRole, userRole);
        createUsers("user", 5, userRole);
    }
    
    Authority createAuthority(String name) {
        value authority = Authority();
        
        authority.name = name;
        
        authorityService.save(authority);
        
        log.info("Created authority ``name``");
        
        return authority;
    }
    
    Role createRole(String name, Authority* authorities) {
        value role = Role();
        
        role.name = name;
        role.authorities = JavaList(authorities);
        
        roleService.save(role);
        
        log.info("Created role ``name``");
        
        return role;
    }
    
    void createUsers(String usernamePrefix, Integer count, Role* roles) {
        for (id in 1..count) {
            value user = User();
            value username = "``usernamePrefix````id``";
            
            user.username = username;
            userService.setPassword(user, username);
            
            for (role in roles) {
                user.roles.add(role);
            }
            
            userService.save(user);
            
            log.info("Created user ``username``");
        }
    }
}
