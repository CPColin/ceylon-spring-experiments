import ceylon.test {
    assertEquals,
    assertNotEquals,
    assumeTrue,
    beforeTest,
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
    
    beforeTest
    shared void setup() {
        productRepository.deleteAll();
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
        assumeTrue(productRepository.count() == 0);
        
        productRepository.save(product);
        
        assertEquals(productRepository.count(), 1);
    }
    
    test
    shared void testDeleteAll() {
        productRepository.save(product);
        
        assertEquals(productRepository.count(), 1);
        
        productRepository.deleteAll();
        
        assertEquals(productRepository.count(), 0);
    }
    
    test
    shared void testFindAll() {
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

/* TODO
 
    <ConcreteEntity extends Entity> ConcreteEntity save(@NonNull ConcreteEntity entity);
    <ConcreteEntity extends Entity> List<ConcreteEntity> saveAll(@NonNull Iterable<ConcreteEntity> entities);
    Optional<Entity> findById(@NonNull Id id);
    boolean existsById(@NonNull Id id);
    List<Entity> findAll();
    List<Entity> findAllById(@NonNull Iterable<Id> ids);
    long count();
    void deleteById(@NonNull Id id);
    void delete(@NonNull Entity entity);
    void deleteAll(@NonNull Iterable<? extends Entity> entities);
    List<Entity> findAll(@NonNull Sort sort);
    void flush();
    <ConcreteEntity extends Entity> ConcreteEntity saveAndFlush(@NonNull ConcreteEntity entity);
    void deleteInBatch(@NonNull Iterable<Entity> entities);
    void deleteAllInBatch();
    Entity getOne(@NonNull Id id);
    <ConcreteEntity extends Entity> List<ConcreteEntity> findAll(@NonNull Example<ConcreteEntity> example);
    <ConcreteEntity extends Entity> List<ConcreteEntity> findAll(@NonNull Example<ConcreteEntity> example, @NonNull Sort sort);
    Page<Entity> findAll(@NonNull Pageable pageable);
    <ConcreteEntity extends Entity> Optional<ConcreteEntity> findOne(@NonNull Example<ConcreteEntity> example);
    <ConcreteEntity extends Entity> Page<ConcreteEntity> findAll(@NonNull Example<ConcreteEntity> example, @NonNull Pageable pageable);
    <ConcreteEntity extends Entity> long count(@NonNull Example<ConcreteEntity> example);
    <ConcreteEntity extends Entity> boolean exists(@NonNull Example<ConcreteEntity> example);

 */