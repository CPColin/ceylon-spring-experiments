import demo.domain {
    Product
}
import demo.repositories {
    ProductRepository
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
class ProductServiceImpl() satisfies ProductService {
    autowired late ProductRepository productRepository;
    
    shared actual Product? getProductById(Integer id)
            => productRepository.findOne(id);
}
