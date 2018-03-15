import demo.domain {
    Authority
}
import demo.repositories {
    AuthorityRepository
}
import demo.services {
    AuthorityService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
shared class AuthorityServiceImpl()
        extends CrudServiceImpl<Authority>()
        satisfies AuthorityService {
    autowired
    shared actual late AuthorityRepository repository;
}
