import interop.spring.dates {
    DateConverter,
    TimeConverter,
    YearMonthConverter
}

import org.springframework.boot.autoconfigure.domain {
    entityScan
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
// It's not clear why this has to be entityScan and not componentScan, but it does.
// It's also not clear why the scan doesn't register the formatter.
entityScan { basePackages = ["interop.spring.dates"]; }
shared class WebMvcConfiguration() satisfies WebMvcConfigurer {
    shared actual void addFormatters(FormatterRegistry registry) {
        registry.addFormatter(DateConverter());
        registry.addFormatter(TimeConverter());
        registry.addFormatter(YearMonthConverter());
    }
}
