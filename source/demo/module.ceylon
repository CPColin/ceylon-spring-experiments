"An example of combining Ceylon, Spring Boot, and Thymeleaf to make a web application."
native("jvm")
module demo "1.0.0" {
    value ceylonVersion = "1.3.3";
    value javaVersion = "8";
    value springBootVersion = "2.0.4.RELEASE";
    
    shared import java.base javaVersion;
    shared import java.jdbc javaVersion;
    
    import ceylon.interop.java ceylonVersion;
    import ceylon.time ceylonVersion;
    
    // Repository utility code
    shared import interop.spring "1.0.0";
    
    shared import maven:org.springframework.boot:"spring-boot-starter-data-jpa" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-thymeleaf" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-security" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-web" springBootVersion;
    
    import maven:org.thymeleaf.extras:"thymeleaf-extras-springsecurity4" "3.0.2.RELEASE";
    
    import maven:com.h2database:"h2" "1.4.197";
    
    import maven:org.webjars:"bootstrap" "3.3.7-1";
    
    import maven:org.webjars:"momentjs" "2.22.2";
}
