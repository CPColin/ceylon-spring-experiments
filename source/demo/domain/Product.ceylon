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
    
    shared variable String productId = "";
    shared variable String description = "";
    shared variable String imageUrl = "";
    shared variable BigDecimal price = BigDecimal.zero;
}
