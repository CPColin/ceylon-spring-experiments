import interop.spring {
    CeylonRepositoryImpl
}

import org.springframework.boot.autoconfigure {
    enableAutoConfiguration
}
import org.springframework.boot.autoconfigure.domain {
    entityScan
}
import org.springframework.context.annotation {
    configuration
}
import org.springframework.data.jpa.repository.config {
    enableJpaRepositories
}
import org.springframework.transaction.annotation {
    enableTransactionManagement
}

configuration
enableAutoConfiguration
// This package might as well be called demo.entity instead, huh?
entityScan { basePackages = ["demo.domain", "interop.spring.dates"]; }
// Scan our repository instances and specify the concrete class to use during injection.
enableJpaRepositories {
    basePackages = ["demo.repositories"];
    repositoryBaseClass = `class CeylonRepositoryImpl`;
}
enableTransactionManagement
class RepositoryConfiguration() {}
