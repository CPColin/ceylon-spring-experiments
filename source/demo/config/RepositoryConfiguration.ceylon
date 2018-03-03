import ceylon.interop.spring {
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
entityScan { basePackages = ["demo.domain"]; }
enableJpaRepositories {
    basePackages = ["demo.repositories"];
    repositoryBaseClass = `class CeylonRepositoryImpl`;
}
enableTransactionManagement
class RepositoryConfiguration() {}
