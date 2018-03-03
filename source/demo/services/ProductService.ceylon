import demo.domain {
    Product
}

shared interface ProductService {
    shared formal Product? getProductById(Integer id);
}
