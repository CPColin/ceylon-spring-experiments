import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.context.annotation {
    configuration
}
import org.springframework.security.config.annotation.authentication.builders {
    AuthenticationManagerBuilder
}
import org.springframework.security.config.annotation.web.builders {
    HttpSecurity
}
import org.springframework.security.config.annotation.web.configuration {
    WebSecurityConfigurerAdapter,
    enableWebSecurity
}
import org.springframework.security.crypto.password {
    NoOpPasswordEncoder
}

configuration
enableWebSecurity
class SecurityConfiguration() extends WebSecurityConfigurerAdapter() {
    shared actual void configure(HttpSecurity httpSecurity) {
        httpSecurity
            .authorizeRequests()
                .antMatchers("/webjars/**", "/console/**").permitAll()
                .and()
            .authorizeRequests()
                .antMatchers("/").permitAll()
                .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/login").permitAll()
                .and()
            .logout()
                .permitAll()
        ;
        
        // Allow the DB Console to work right.
        httpSecurity.csrf().disable();
        httpSecurity.headers().frameOptions().disable();
    }
    
    suppressWarnings("deprecation")
    autowired
    shared void configureGlobal(AuthenticationManagerBuilder auth) {
        auth
            .inMemoryAuthentication()
                .passwordEncoder(NoOpPasswordEncoder.instance)
                .withUser("admin").password("admin").roles("ADMIN")
                .and()
                .withUser("user").password("user").roles("USER");
    }
    //
    //bean
    //shared PasswordEncoder passwordEncoder() => PasswordEncoderFactories.createDelegatingPasswordEncoder();
}
