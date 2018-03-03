import demo.services {
    ProductService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    controller
}
import org.springframework.ui {
    Model
}
import org.springframework.web.bind.annotation {
    pathVariable,
    requestMapping
}

controller
class ProductController() {
    autowired late ProductService productService;
    
    requestMapping(["product/{id}"])
    shared String details(pathVariable Integer id, Model model) {
        model.addAttribute("product", productService.getProductById(id));
        
        return "productDetails";
    }
}
