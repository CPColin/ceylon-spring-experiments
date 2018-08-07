import org.springframework.context.annotation {
    bean,
    configuration
}
import org.thymeleaf.templatemode {
    TemplateMode
}
import org.thymeleaf.templateresolver {
    ITemplateResolver,
    FileTemplateResolver
}

configuration
shared class ThymeleafConfiguration() {
    "Loads templates from the file system, instead of the module resources, allowing for changes
     without restarting the application. This should have an environment check."
    bean
    shared ITemplateResolver templateResolver() {
        value templateResolver = FileTemplateResolver();
        
        templateResolver.cacheable = false;
        templateResolver.templateMode = TemplateMode.html;
        templateResolver.prefix = "resource/demo/ROOT/templates/";
        templateResolver.suffix = ".html";
        
        return templateResolver;
    }
}
