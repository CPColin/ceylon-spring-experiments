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

import org.apache.logging.log4j {
    LogManager
}
import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.context {
    ApplicationListener
}
import org.springframework.context.event {
    ContextRefreshedEvent
}
import org.springframework.stereotype {
    component
}

"Populates our Product table with a few values, for debugging."
component
class ProductLoader() satisfies ApplicationListener<ContextRefreshedEvent> {
    autowired late ProductRepository productRepository;
    
    value log = LogManager.getLogger(`ProductLoader`);
    
    shared actual void onApplicationEvent(ContextRefreshedEvent event) {
        value shirt = Product {
            description = "Spring Framework Guru Shirt";
            imageUrl = "https://springframework.guru/wp-content/uploads/2015/04/spring_framework_guru_shirt-rf412049699c14ba5b68bb1c09182bfa2_8nax2_512.jpg";
            price = BigDecimal("18.95");
            productId = "235268845711068308";
            productType = ProductType.shirt;
        };
        
        productRepository.save(shirt);
        
        log.info("Saved Shirt - id: ``shirt.id else 0``");
        
        value mug = Product {
            description = "Spring Framework Guru Mug";
            imageUrl = "https://springframework.guru/wp-content/uploads/2015/04/spring_framework_guru_coffee_mug-r11e7694903c348e1a667dfd2f1474d95_x7j54_8byvr_512.jpg";
            price = BigDecimal("11.95");
            productId = "168639393495335947";
            productType = ProductType.mug;
        };
        
        productRepository.save(mug);
        
        log.info("Saved Mug - id: ``mug.id else 0``");
    }
}
