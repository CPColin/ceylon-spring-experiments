import ceylon.interop.java {
    CeylonIterable,
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
    Product,
    ProductType
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
import org.springframework.dao {
    IncorrectResultSizeDataAccessException
}
import org.springframework.data.domain {
    Example,
    ExampleMatcher {
        StringMatcher
    },
    PageRequest,
    Sort {
        Direction
    }
}
import org.springframework.transaction.annotation {
    transactional
}

"Verifies that our Spring integration in [[interop.spring::CeylonRepository]] and
 [[interop.spring::CeylonRepositoryImpl]] is working properly, via [[ProductRepository]]."
transactional
shared class ProductRepositoryTests() {
    autowired late ProductRepository productRepository;
    
    "A single entity that can be used for testing single-value operations."
    value product {
        value product = Product();
        
        product.description = "Ceylon Bumper Sticker";
        product.imageUrl = "";
        product.price = BigDecimal.zero;
        product.productId = "1234";
        product.productType = ProductType.mug;

        return product;
    }
    
    value targetWord = "Good";
    value nonTargetWord = "Bad";
    
    "A trio of entities that can be used for testing multi-value operations."
    value products {
        value product1 = Product();
        
        product1.description = "A ``targetWord`` Product";
        
        value product2 = Product();
        
        product2.description = "Another ``targetWord`` Product";
        
        value product3 = Product();
        
        product3.description = "A ``nonTargetWord`` Product";
        
        return {product1, product2, product3};
    }
    
    function example(String word) {
        value exampleProduct = Product();
        
        exampleProduct.description = word;
        
        value exampleMatcher = ExampleMatcher.matching().withStringMatcher(StringMatcher.containing);
        
        return Example.\iof(exampleProduct, exampleMatcher);
    }
    
    beforeTest
    shared void setup() {
        // Start the repository off clean, free of any bootstrapped values.
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
        productRepository.saveAll(JavaIterable(products));
        
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
        productRepository.saveAll(JavaIterable(products));
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        productRepository.deleteAll();
        
        assertEquals(productRepository.count(), 0, "No entities should remain in the repository.");
    }
    
    test
    shared void testDeleteAllEntities() {
        productRepository.saveAll(JavaIterable(products));
        
        value savedProducts = productRepository.findAll();
        
        assumeTrue(savedProducts.size() > 1, "Need to have more than one test product.");
        
        value first = savedProducts.remove(0);
        
        productRepository.deleteAll(savedProducts);
        
        value remainingProducts = productRepository.findAll();
        
        assertEquals(remainingProducts.size(), 1, "One product should be left.");
        assertProductsEqual(remainingProducts.get(0), first, "Unexpected product remained.");
    }
    
    test
    shared void testDeleteAllInBatch() {
        productRepository.saveAll(JavaIterable(products));
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        productRepository.deleteAllInBatch();
        
        assertEquals(productRepository.count(), 0, "No entities should remain in the repository.");
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
    shared void testDeleteInBatch() {
        productRepository.saveAll(JavaIterable(products));
        
        value savedProducts = productRepository.findAll();
        
        assumeTrue(savedProducts.size() > 1, "Need to have more than one test product.");
        
        value first = savedProducts.remove(0);
        
        productRepository.deleteInBatch(savedProducts);
        
        value remainingProducts = productRepository.findAll();
        
        assertEquals(remainingProducts.size(), 1, "One product should be left.");
        assertProductsEqual(remainingProducts.get(0), first, "Unexpected product remained.");
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
        productRepository.saveAll(JavaIterable(products));
        
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
    shared void testFindAllExample() {
        productRepository.saveAll(JavaIterable(products));
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        value example = this.example(targetWord);
        value fetchedProducts = productRepository.findAll(example);
        
        assertEquals(fetchedProducts.size(), 2, "Exactly two entities should match the example.");
        assertTrue(CeylonIterable(fetchedProducts).every((product) => product.description.contains(targetWord)),
            "One or more returned entities is missing the target word.");
    }
    
    test
    shared void testFindAllExamplePage() {
        productRepository.saveAll(JavaIterable(products));
        
        value expectedProductDescriptions = products
                .map((product) => product.description)
                .filter((description) => description.contains(targetWord))
                .sort(byIncreasing(identity<String>))
                .sequence();
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        assumeTrue(expectedProductDescriptions.size == 2, "Expected two descriptions.");
        
        // The latter one
        value expectedProductDescription = expectedProductDescriptions[1];
        
        assert (exists expectedProductDescription);
        
        value example = this.example(targetWord);
        value sort = Sort(Direction.asc, "description");
        // The latter one
        value pageRequest = PageRequest.\iof(1, 1, sort);
        
        value fetchedProducts = productRepository.findAll(example, pageRequest);
        
        assertEquals(fetchedProducts.totalElements, 2, "Unexpected total size.");
        assertEquals(fetchedProducts.size, 1, "Unexpected page size.");
        assertEquals(fetchedProducts.content.get(0).description, expectedProductDescription, "Unexpected element.");
    }
    
    test
    shared void testFindAllExampleSort() {
        productRepository.saveAll(JavaIterable(products));
        
        value expectedProductDescriptions = products
                .map((product) => product.description)
                .filter((description) => description.contains(targetWord))
                .sort(byIncreasing(identity<String>))
                .sequence();
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        assumeTrue(expectedProductDescriptions.size == 2, "Expected two descriptions.");
        
        value example = this.example(targetWord);
        value sort = Sort(Direction.asc, "description");
        
        value fetchedProductDescriptions = CeylonIterable(productRepository.findAll(example, sort))
                .map((product) => product.description)
                .sequence();
        
        assertEquals(fetchedProductDescriptions, expectedProductDescriptions,
            "Fetched descriptions did not matched saved descriptions.");
    }

    test
    shared void testFindAllPage() {
        productRepository.saveAll(JavaIterable(products));
        
        value savedProductDescriptions = products
                .map((product) => product.description)
                .sort(byIncreasing(identity<String>))
                .sequence();
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        assumeTrue(savedProductDescriptions.size == 3, "Expected three entities.");
        
        // The middle one!
        value expectedProductDescription = savedProductDescriptions[1];
        
        assert (exists expectedProductDescription);
        
        value sort = Sort(Direction.asc, "description");
        // The middle one!
        value pageRequest = PageRequest.\iof(1, 1, sort);
        
        value fetchedProducts = productRepository.findAll(pageRequest);
        
        assertEquals(fetchedProducts.totalElements, 3, "Unexpected total size.");
        assertEquals(fetchedProducts.size, 1, "Unexpected page size.");
        assertEquals(fetchedProducts.content.get(0).description, expectedProductDescription, "Unexpected element.");
    }
    
    test
    shared void testFindAllSort() {
        productRepository.saveAll(JavaIterable(products));
        
        value savedProductDescriptions = products
                .map((product) => product.description)
                .sort(byIncreasing(identity<String>))
                .sequence();
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        assumeTrue(savedProductDescriptions.size == 3, "Expected three descriptions.");
        
        value sort = Sort(Direction.asc, "description");
        
        value fetchedProductDescriptions = CeylonIterable(productRepository.findAll(sort))
                .map((product) => product.description)
                .sequence();
        
        assertEquals(fetchedProductDescriptions, savedProductDescriptions,
            "Fetched descriptions did not matched saved descriptions.");
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
    shared void testFindOne() {
        productRepository.saveAll(JavaIterable(products));
        
        value expectedProduct = CeylonIterable(productRepository.findAll())
                .find((product) => product.description.contains(nonTargetWord));
        
        assert (exists expectedProduct);
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        value fetchedProduct = productRepository.findOne(this.example(nonTargetWord)).get();
        
        assertProductsEqual(fetchedProduct, expectedProduct, "Fetched product did not match expected product.");
    }
    
    test
    shared void testFindOneMatchesMultiple() {
        assumeTrue(products.count((product) => product.description.contains(targetWord)) > 1);
        
        productRepository.saveAll(JavaIterable(products));
        
        assumeTrue(productRepository.count() == 3, "Products did not save properly.");
        
        assertThatException(() => productRepository.findOne(this.example(targetWord)).get())
                .hasType(`IncorrectResultSizeDataAccessException`);
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
    shared void testSaveAll() {
        value savedProductDescriptions = products
                .map((product) => product.description)
                .sort(byIncreasing(identity<String>))
                .sequence();
        
        productRepository.saveAll(JavaIterable(products));
        
        value fetchedProductDescriptions = CeylonIterable(productRepository.findAll())
                .map((product) => product.description)
                .sort(byIncreasing(identity<String>))
                .sequence();
        
        assertEquals(fetchedProductDescriptions, savedProductDescriptions,
            "Fetched entities didn't match saved entities.");
    }
    
    test
    shared void testSaveAndFlushPopulatesId() {
        assumeFalse(product.id exists, "Product ID should start off null.");
        
        value savedProduct = productRepository.saveAndFlush(product);
        
        assertTrue(savedProduct.id exists, "Product ID should no longer be null.");
    }
    
    test
    shared void testSaveAndFlushPopulatesSaved() {
        assumeFalse(product.saved, "Product ID should start off null.");
        
        value savedProduct = productRepository.saveAndFlush(product);
        
        assertTrue(savedProduct.saved, "Product ID should no longer be null.");
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
            () => assertEquals(actual.productId, expected.productId),
            () => assertEquals(actual.productType, expected.productType)
        ], message);
    }
}
