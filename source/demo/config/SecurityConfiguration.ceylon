import demo.services.impl {
    UserServiceImpl
}

import java.lang {
    overloaded
}

import org.springframework.context.annotation {
    bean,
    configuration
}
import org.springframework.security.config.annotation.authentication.builders {
    AuthenticationManagerBuilder
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

"Configures the security settings for our application."
configuration
enableWebSecurity
enableGlobalMethodSecurity { prePostEnabled = true; securedEnabled = true; }
class SecurityConfiguration() extends WebSecurityConfigurerAdapter() {
    overloaded
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
    shared PasswordEncoder passwordEncoder()
            => PasswordEncoderFactories.createDelegatingPasswordEncoder();
    
    bean
    shared actual UserDetailsService userDetailsService() => UserServiceImpl();
    
    overloaded
    shared actual void configure(AuthenticationManagerBuilder auth) {
        auth
            .userDetailsService(userDetailsService())
            .passwordEncoder(passwordEncoder());
    }
}
