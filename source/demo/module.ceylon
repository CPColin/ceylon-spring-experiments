native("jvm")
module demo "1.0.0" {
    value ceylonVersion = "1.3.3";
    value springBootVersion = "2.0.0.RELEASE";
    
    shared import java.base "8";
    shared import com.redhat.ceylon.common ceylonVersion;
    
    shared import maven:org.springframework.boot:"spring-boot-starter-data-jpa" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-thymeleaf" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-security" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-web" springBootVersion;
    
    // Not in Maven Central yet. Grab it off my GitHub and install it locally.
    import maven:org.thymeleaf.extras:"thymeleaf-extras-springsecurity5" "3.0.3-SNAPSHOT";
    
    import maven:com.h2database:"h2" "1.4.196";
    
    import maven:org.webjars:"bootstrap" "3.3.7-1";
}
