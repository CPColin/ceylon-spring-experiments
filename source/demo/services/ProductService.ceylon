import demo.domain {
    Product
}

import java.lang {
    JIterable=Iterable
}

shared interface ProductService {
    shared formal void delete(Integer id);
    
    shared formal JIterable<Product> getAll();
    
    shared formal Product? getById(Integer id);
    
    shared formal void save(Product product);
}
