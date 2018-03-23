import demo.domain {
    Product
}
import demo.repositories {
    ProductRepository
}
import demo.services {
    ProductService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
class ProductServiceImpl()
        extends CrudServiceImpl<Product>()
        satisfies ProductService {
    autowired
    shared actual late ProductRepository repository;
}
