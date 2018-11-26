"A copy of the `ceylon.interop.spring` module, modified to work with Spring 5, plus some other
 utility functionality for working with Spring."
native("jvm")
module interop.spring "1.0.0" {
    value ceylonVersion = "1.3.3";
    value javaVersion = "8";
    value springDataVersion = "2.1.2.RELEASE";
    
    shared import java.base javaVersion;
    shared import java.jdbc javaVersion;
    
    shared import ceylon.interop.java ceylonVersion;
    shared optional import ceylon.time ceylonVersion;
    
    shared import maven:org.springframework.data:"spring-data-commons" springDataVersion;
    shared import maven:org.springframework.data:"spring-data-jpa" springDataVersion;
    shared import maven:org.springframework:"spring-tx" "5.1.2.RELEASE";
    
    shared import maven:"org.hibernate.javax.persistence:hibernate-jpa-2.1-api" "1.0.2.Final";
}
