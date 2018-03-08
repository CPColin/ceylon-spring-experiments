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
shared class Product(productId = "", description = "", imageUrl = "", price = BigDecimal.zero) {
    id
    generatedValue
    shared Integer? id = null;
    
    version
    shared Integer? version = null;
    
    shared String productId;
    shared String description;
    shared String imageUrl;
    shared BigDecimal price;
}
