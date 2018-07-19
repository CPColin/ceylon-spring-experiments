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
