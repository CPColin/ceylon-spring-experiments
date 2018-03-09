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
import org.springframework.context {
	ApplicationListener
}
import org.springframework.context.event {
	ContextRefreshedEvent
}
import org.springframework.stereotype {
	component
}

component
class ProductLoader() satisfies ApplicationListener<ContextRefreshedEvent> {
    autowired late ProductRepository productRepository;
    
    //value log = Logger.getLogger(`ProductLoader`);
    
    shared actual void onApplicationEvent(ContextRefreshedEvent event) {
        value shirt = Product();
        
        shirt.description = "Spring Framework Guru Shirt";
        shirt.imageUrl = "https://springframework.guru/wp-content/uploads/2015/04/spring_framework_guru_shirt-rf412049699c14ba5b68bb1c09182bfa2_8nax2_512.jpg";
        shirt.price = BigDecimal("18.95");
        shirt.productId = "235268845711068308";
        
        productRepository.save(shirt);
        
        //log.info("Saved Shirt - id: ``shirt.id else "?"``");
        
        value mug = Product();
        
        mug.description = "Spring Framework Guru Mug";
        mug.imageUrl = "https://springframework.guru/wp-content/uploads/2015/04/spring_framework_guru_coffee_mug-r11e7694903c348e1a667dfd2f1474d95_x7j54_8byvr_512.jpg";
        mug.price = BigDecimal("11.95");
        mug.productId = "168639393495335947";
        
        productRepository.save(mug);
        
        //log.info("Saved Mug - id: ``mug.id else "?"``");
    }
}
