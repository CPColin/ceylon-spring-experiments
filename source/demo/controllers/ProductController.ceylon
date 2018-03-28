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
import org.springframework.security.access.prepost {
    preAuthorize
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
    secured(["ROLE_ADMIN"])
    shared String delete(pathVariable Integer id) {
        productService.delete(id);
        
        return "redirect:/products";
    }
    
    requestMapping(["product/{id}"])
    secured(["ROLE_ADMIN", "ROLE_USER"])
    shared String details(pathVariable Integer id, Model model) {
        model.addAttribute("product", productService.getById(id));
        
        return "productDetails";
    }
    
    requestMapping(["product/edit/{id}"])
    secured(["ROLE_ADMIN"])
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
    preAuthorize("hasAuthority('MANAGE_PRODUCTS')")
    shared String newProduct(Model model) {
        value product = Product();
        
        product.id = 0;
        product.version = 0;
        
        model.addAttribute("product", product);
        
        return "productForm";
    }
    
    requestMapping { \ivalue = ["product"]; method = [RequestMethod.post]; }
    secured(["ROLE_ADMIN"])
    shared String saveProduct(Product product) {
        value savedProduct = productService.save(product);
        
        return "redirect:product/``savedProduct.id else 0``";
    }
}
