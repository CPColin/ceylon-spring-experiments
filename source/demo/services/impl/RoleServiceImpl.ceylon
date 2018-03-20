import demo.domain {
    Role
}
import demo.repositories {
    RoleRepository
}
import demo.services {
    RoleService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
shared class RoleServiceImpl()
        extends CrudServiceImpl<Role>()
        satisfies RoleService {
    autowired
    shared actual late RoleRepository repository;
}
