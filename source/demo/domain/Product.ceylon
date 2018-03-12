import java.math {
    BigDecimal
}

import javax.persistence {
    entity,
    id,
    generatedValue,
    version
}

entity
shared class Product() {
    id
    generatedValue
    shared late Integer id;
    
    version
    shared late Integer version;
    
    // These all have to be annotated variable so Spring knows how to update them.
    // Keeping logic out of these classes is probably a good idea, to make up for the mutability.
    
    shared variable String productId = "";
    shared variable String description = "";
    shared variable String imageUrl = "";
    shared variable BigDecimal price = BigDecimal.zero;
}
