import demo.domain {
    Product
}

import java.util {
    JList=List
}

shared interface ProductService {
    shared formal void delete(Integer id);
    
    shared formal JList<Product> getAll();
    
    shared formal Product? getById(Integer id);
    
    shared formal void save(Product product);
}
