import ceylon.interop.java {
    JavaIterable
}
import ceylon.test {
    assertAll,
    assertEquals,
    assertFalse,
    assertThatException,
    assertTrue,
    assumeFalse,
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

import javax.persistence {
    EntityNotFoundException
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.data.domain {
    Example,
    ExampleMatcher {
        StringMatcher
    }
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
    
    value targetWord = "Good";
    value nonTargetWord = "Bad";
    
    value products {
        value product1 = Product();
        
        product1.description = "A ``targetWord`` Product";
        
        value product2 = Product();
        
        product2.description = "Another ``targetWord`` Product";
        
        value product3 = Product();
        
        product3.description = "A ``nonTargetWord`` Product";
        
        return JavaIterable {product1, product2, product3};
    }
    
    function example(String word) {
        value exampleProduct = Product();
        
        exampleProduct.description = word;
        
        value exampleMatcher = ExampleMatcher.matching().withStringMatcher(StringMatcher.containing);
        
        return Example.\iof(exampleProduct, exampleMatcher);
    }
    
    beforeTest
    shared void setup() {
        productRepository.deleteAll();
    }
    
    test
    shared void testCount() {
        assumeTrue(productRepository.count() == 0, "The repository should start off empty.");
        
        productRepository.save(product);
        
        assertEquals(productRepository.count(), 1, "The repository should now have one entity in it.");
    }
    
    test
    shared void testCountExample() {
        productRepository.saveAll(products);
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        value example = this.example(targetWord);
        
        assertEquals(productRepository.count(example), 2, "Exactly two entities should match the example.");
    }
    
    test
    shared void testDelete() {
        value savedProduct = productRepository.save(product);
        value id = savedProduct.id;
        
        assert (exists id);
        
        assumeTrue(productRepository.existsById(id), "Test product did not save properly.");
        
        productRepository.delete(savedProduct);
        
        assertFalse(productRepository.existsById(id), "Product should no longer exist in the repository.");
    }
    
    test
    shared void testDeleteAll() {
        productRepository.save(product);
        
        assertEquals(productRepository.count(), 1);
        
        productRepository.deleteAll();
        
        assertEquals(productRepository.count(), 0);
    }
    
    test
    shared void testDeleteAllEntities() {
        productRepository.saveAll(products);
        
        value savedProducts = productRepository.findAll();
        
        assumeTrue(savedProducts.size() > 1, "Need to have more than one test product.");
        
        value first = savedProducts.remove(0);
        
        productRepository.deleteAll(savedProducts);
        
        value remainingProducts = productRepository.findAll();
        
        assertEquals(remainingProducts.size(), 1, "One product should be left.");
        assertProductsEqual(remainingProducts.get(0), first, "Unexpected product remained.");
    }
    
    test
    shared void testDeleteById() {
        value savedProduct = productRepository.save(product);
        value id = savedProduct.id;
        
        assert (exists id);
        
        assumeTrue(productRepository.existsById(id), "Test product did not save properly.");
        
        productRepository.deleteById(id);
        
        assertFalse(productRepository.existsById(id), "Product should no longer exist in the repository.");
    }
    
    test
    shared void testExistsById() {
        value id = productRepository.save(product).id;
        
        assert (exists id);
        
        assertTrue(productRepository.existsById(id), "Saved entity should exist.");
        assertFalse(productRepository.existsById(-1), "Invalid ID should not exist.");
    }
    
    test
    shared void testExistsExample() {
        productRepository.saveAll(products);
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        assertTrue(productRepository.\iexists(this.example(targetWord)), "An entity should match the good example.");
        assertFalse(productRepository.\iexists(this.example("foo")), "No entity should match the bad example.");
    }
    
    test
    shared void testFindAll() {
        value savedProduct = productRepository.save(product);
        
        value products = productRepository.findAll();
        
        assertEquals(products.size(), 1, "One entity was saved, but a different number was found.");
        assertProductsEqual(products.get(0), savedProduct, "Fetched product did not match saved product.");
    }
    
    test
    shared void testFindAllById() {
        value savedProduct1 = productRepository.save(product);
        value id1 = savedProduct1.id;
        value savedProduct2 = productRepository.save(product);
        value id2 = savedProduct2.id;
        
        assert (exists id1, exists id2);
        
        assumeFalse(id1 == id2, "Saved ID's should differ.");
        assumeTrue(productRepository.count() == 2, "There should be two entities in the repository.");
        
        value products = productRepository.findAllById(JavaIterable {id2});
        
        assertEquals(products.size(), 1, "Only one product should have been returned.");
        assertProductsEqual(products.get(0), savedProduct2, "Fetched product did not match saved product.");
    }
    
    test
    shared void testFindById() {
        value savedProduct = productRepository.save(product);
        value id = savedProduct.id;
        
        assert (exists id);
        
        value fetchedProduct = productRepository.findById(id).get();
        
        assertProductsEqual(fetchedProduct, savedProduct, "Fetched product did not match saved product.");
    }
    
    test
    shared void testFindByIdMissing() {
        value fetchedProduct = productRepository.findById(-1);
        
        assertFalse(fetchedProduct.present);
    }
    
    test
    shared void testFlush() {
        productRepository.save(product);
        
        productRepository.flush();
        
        // No assertions; just need to make sure the call completes.
    }
    
    test
    shared void testGetOne() {
        value savedProduct = productRepository.save(product);
        value id = savedProduct.id;
        
        assert (exists id);
        
        assumeTrue(savedProduct.saved, "The test product did not successfully save.");
        
        value fetchedProduct = productRepository.getOne(id);
        
        assertProductsEqual(fetchedProduct, savedProduct, "Fetched product did not match saved product.");
    }
    
    test
    shared void testGetOneFailure() {
        value id = -1;
        
        assumeFalse(productRepository.existsById(id), "Found an entity with the ID that's supposed to be missing.");
        
        void getMissing() {
            value missingProduct = productRepository.getOne(id);
            
            assertEquals(missingProduct.productId, "",
                "Have to access a field in the entity, in case it was fetched lazily.");
        }
        
        assertThatException(getMissing).hasType(`EntityNotFoundException`);
    }
    
    test
    shared void testSavePopulatesId() {
        assumeFalse(product.id exists, "Product ID should start off null.");
        
        value savedProduct = productRepository.save(product);
        
        assertTrue(savedProduct.id exists, "Product ID should no longer be null.");
    }
    
    test
    shared void testSavePopulatesSaved() {
        assumeFalse(product.saved, "Product.saved should start off false.");
        
        value savedProduct = productRepository.save(product);
        
        assertTrue(savedProduct.saved, "Product.saved should no longer be false.");
    }
    
    void assertProductsEqual(Product actual, Product expected, String? message = null) {
        assertAll([
            () => assertEquals(actual.id, expected.id),
            () => assertEquals(actual.description, expected.description),
            () => assertEquals(actual.imageUrl, expected.imageUrl),
            //() => assertEquals(actual.price, expected.price),
            () => assertEquals(actual.productId, expected.productId)
        ], message);
    }
}

/* TODO
 
    void deleteAllInBatch();
    void deleteInBatch(@NonNull Iterable<Entity> entities);
    <ConcreteEntity extends Entity> List<ConcreteEntity> findAll(@NonNull Example<ConcreteEntity> example);
    <ConcreteEntity extends Entity> Page<ConcreteEntity> findAll(@NonNull Example<ConcreteEntity> example, @NonNull Pageable pageable);
    <ConcreteEntity extends Entity> List<ConcreteEntity> findAll(@NonNull Example<ConcreteEntity> example, @NonNull Sort sort);
    Page<Entity> findAll(@NonNull Pageable pageable);
    List<Entity> findAll(@NonNull Sort sort);
    <ConcreteEntity extends Entity> Optional<ConcreteEntity> findOne(@NonNull Example<ConcreteEntity> example);
    <ConcreteEntity extends Entity> List<ConcreteEntity> saveAll(@NonNull Iterable<ConcreteEntity> entities);
    <ConcreteEntity extends Entity> ConcreteEntity saveAndFlush(@NonNull ConcreteEntity entity);

 */
