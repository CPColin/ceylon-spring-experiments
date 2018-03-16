import demo.domain {
    Product
}
import demo.services {
    ProductService
}

import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.security.access.annotation {
    secured
}
import org.springframework.stereotype {
    controller
}
import org.springframework.ui {
    Model
}
import org.springframework.web.bind.annotation {
    RequestMethod,
    pathVariable,
    requestMapping
}

controller
class ProductController() {
    autowired late ProductService productService;
    
    requestMapping(["product/delete/{id}"])
    secured(["ADMIN"])
    shared String delete(pathVariable Integer id) {
        productService.delete(id);
        
        return "redirect:/products";
    }
    
    requestMapping(["product/{id}"])
    secured(["ADMIN", "USER"])
    shared String details(pathVariable Integer id, Model model) {
        model.addAttribute("product", productService.getById(id));
        
        return "productDetails";
    }
    
    requestMapping(["product/edit/{id}"])
    secured(["ADMIN"])
    shared String editProduct(pathVariable Integer id, Model model) {
        model.addAttribute("product", productService.getById(id));
        
        return "productForm";
    }
    
    requestMapping(["/products"])
    shared String list(Model model) {
        model.addAttribute("products", productService.getAll());
        
        return "productList";
    }
    
    requestMapping(["product/new"])
    secured(["ADMIN"])
    shared String newProduct(Model model) {
        model.addAttribute("product", Product());
        
        return "productForm";
    }
    
    requestMapping { \ivalue = ["product"]; method = [RequestMethod.post]; }
    secured(["ADMIN"])
    shared String saveProduct(Product product) {
        productService.save(product);
        
        return "redirect:product/``product.id``";
    }
}
