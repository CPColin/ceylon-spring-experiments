native("jvm")
module demo "1.0.0" {
	value ceylonVersion = "1.3.3";
    value springBootVersion = "2.0.0.RELEASE";
    
    shared import java.base "8";
    shared import ceylon.interop.spring ceylonVersion;
    shared import com.redhat.ceylon.common ceylonVersion;
    
    shared import maven:org.springframework.boot:"spring-boot-starter-data-jpa" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-thymeleaf" springBootVersion;
    shared import maven:org.springframework.boot:"spring-boot-starter-web" springBootVersion;
    
    import maven:com.h2database:"h2" "1.4.196";
    
    import maven:org.webjars:"bootstrap" "3.3.7-1";
}
