import ceylon.test {
    assertEquals,
    assertNotEquals,
    test
}

import demo.domain {
    Product
}
import demo.repositories {
    ProductRepository
}

import java.math {
    BigDecimal
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.transaction.annotation {
    transactional
}

transactional
shared class ProductRepositoryTests() {
    autowired late ProductRepository productRepository;
    
    value product {
        value product = Product();
        
        product.description = "Ceylon Bumper Sticker";
        product.imageUrl = "";
        product.price = BigDecimal.zero;
        product.productId = "1234";

        return product;
    }
    
    test
    shared void testIdIsPopulated() {
        value product = this.product;
        
        assertEquals(product.id, 0);
        productRepository.save(product);
        assertNotEquals(product.id, 0);
    }
    
    test
    shared void testFetchOne() {
        value product = this.product;
        
        productRepository.save(product);
        
        value fetchedProduct = productRepository.findById(product.id).get();
        
        assertProductsEqual(fetchedProduct, product);
    }
    
    test
    shared void testCount() {
        productRepository.deleteAll();
        
        productRepository.save(product);
        
        assertEquals(productRepository.count(), 1);
    }
    
    test
    shared void testFindAll() {
        productRepository.deleteAll();
        
        value product = this.product;
        
        productRepository.save(product);
        
        value products = productRepository.findAll();
        
        assertEquals(products.size(), 1);
        assertProductsEqual(products.get(0), product);
    }
    
    void assertProductsEqual(Product actual, Product expected) {
        assertEquals(actual.id, expected.id);
        assertEquals(actual.description, expected.description);
        assertEquals(actual.imageUrl, expected.imageUrl);
        //assertEquals(actual.price, expected.price);
        assertEquals(actual.productId, expected.productId);
    }
}
