import javax.sql {
    DataSource
}

import org.springframework.context.annotation {
    bean,
    configuration
}
import org.springframework.security.config.annotation.method.configuration {
    enableGlobalMethodSecurity
}
import org.springframework.security.config.annotation.web.builders {
    HttpSecurity
}
import org.springframework.security.config.annotation.web.configuration {
    WebSecurityConfigurerAdapter,
    enableWebSecurity
}
import org.springframework.security.core.userdetails {
    UserDetailsService
}
import org.springframework.security.crypto.factory {
    PasswordEncoderFactories
}
import org.springframework.security.crypto.password {
    PasswordEncoder
}
import org.springframework.security.provisioning {
    JdbcUserDetailsManager
}

"Configures the security settings for our application."
configuration
enableWebSecurity
enableGlobalMethodSecurity { securedEnabled = true; }
class SecurityConfiguration() extends WebSecurityConfigurerAdapter() {
    shared actual void configure(HttpSecurity httpSecurity) {
        httpSecurity
            .authorizeRequests()
                .antMatchers("/console/**").permitAll()
                .and()
            .authorizeRequests()
                .antMatchers("/", "/products", "/webjars/**").permitAll()
                .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/login").permitAll()
                .and()
            .logout()
                .permitAll()
        ;
        
        // Allow the DB Console to work right.
        // TODO: See if these lines are still needed.
        httpSecurity.csrf().disable();
        httpSecurity.headers().frameOptions().disable();
    }
    
    bean
    shared UserDetailsService jdbcUserDetailsService(DataSource dataSource) {
        value manager = JdbcUserDetailsManager();
        
        manager.dataSource = dataSource;
        
        return manager;
    }
    
    bean
    shared PasswordEncoder passwordEncoder()
            => PasswordEncoderFactories.createDelegatingPasswordEncoder();
}
