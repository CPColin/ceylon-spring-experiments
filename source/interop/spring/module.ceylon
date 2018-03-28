native("jvm")
module interop.spring "1.0.0" {
    shared import java.base "8";
    
    shared import maven:org.springframework.data:"spring-data-commons" "2.0.5.RELEASE";
    shared import maven:org.springframework.data:"spring-data-jpa" "2.0.5.RELEASE";
    shared import maven:org.springframework:"spring-tx" "5.0.4.RELEASE";
    
    shared import maven:"org.hibernate.javax.persistence:hibernate-jpa-2.1-api" "1.0.2.Final";
}
