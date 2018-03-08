import ceylon.test {
    assertEquals,
    assertNull,
    assertNotNull,
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
    
    value product => Product {
        description = "Ceylon Bumper Sticker";
        imageUrl = "";
        price = BigDecimal.zero;
        productId = "1234";
    };
    
    test
    shared void testIdIsPopulated() {
        value product = this.product;
        
        assertNull(product.id);
        productRepository.save(product);
        assertNotNull(product.id);
    }
    
    test
    shared void testFetchOne() {
        value product = this.product;
        
        productRepository.save(product);
        
        value id = product.id;
        
        assert (exists id);
        
        value fetchedProduct = productRepository.findById(id).get();
        
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
