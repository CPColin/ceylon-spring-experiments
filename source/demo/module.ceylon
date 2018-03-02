native("jvm")
module demo "1.0.0" {
    value springVersion = "1.5.10.RELEASE";
    
    shared import java.base "8";
    shared import ceylon.interop.spring "1.3.3";
    
    shared import maven:org.springframework.boot:"spring-boot-starter-data-jpa" springVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-thymeleaf" springVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-web" springVersion;
    
    import maven:com.h2database:"h2" "1.4.196";
    
    import maven:org.webjars:"bootstrap" "3.3.7-1";
}
