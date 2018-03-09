import demo.domain {
    Product
}
import demo.repositories {
    ProductRepository
}

import java.util {
    JList=List
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
    
    shared actual JList<Product> getAll() => productRepository.findAll();
    
    shared actual Product? getById(Integer id)
            => let (product = productRepository.findById(id))
                if (product.present) then product.get() else null;
    
    shared actual void save(Product product) {
        productRepository.save(product);
    }
}
