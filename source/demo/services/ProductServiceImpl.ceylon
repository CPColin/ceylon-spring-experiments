import demo.domain {
    Product
}
import demo.repositories {
    ProductRepository
}

import java.lang {
    JIterable=Iterable
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
class ProductServiceImpl() satisfies ProductService {
    autowired
    late ProductRepository productRepository;
    
    shared actual void delete(Integer id) {
        productRepository.deleteById(id);
    }
    
    shared actual JIterable<Product> getAll() => productRepository.findAll();
    
    shared actual Product? getById(Integer id)
            => let (product = productRepository.findById(id))
                if (product.present) then product.get() else null;
    
    shared actual void save(Product product) {
        productRepository.save(product);
    }
}
