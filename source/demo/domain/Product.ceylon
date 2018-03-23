import java.math {
    BigDecimal
}

import javax.persistence {
    entity
}

entity
shared class Product() extends Entity() {
    // These all have to be annotated variable so Spring knows how to update them.
    // Keeping logic out of these classes is probably a good idea, to make up for the mutability.
    
    shared variable String productId = "";
    shared variable String description = "";
    shared variable String imageUrl = "";
    shared variable BigDecimal price = BigDecimal.zero;
}
