import interop.spring.dates {
    DateConverter
}

import org.springframework.context.annotation {
    configuration
}
import org.springframework.format {
    FormatterRegistry
}
import org.springframework.web.servlet.config.annotation {
    WebMvcConfigurer
}

configuration
shared class WebMvcConfiguration() satisfies WebMvcConfigurer {
    shared actual void addFormatters(FormatterRegistry registry) {
        registry.addFormatter(DateConverter());
    }
}
