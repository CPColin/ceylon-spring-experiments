import org.h2.server.web {
    WebServlet
}
import org.springframework.boot.web.servlet {
    ServletRegistrationBean
}
import org.springframework.context.annotation {
    bean,
    componentScan,
    configuration
}

configuration
// Manually scan the Thymeleaf Extras package, because the Starter currently scans the package for
// Spring Security 4.
componentScan { basePackages = ["org.thymeleaf.extras.springsecurity5"]; }
class WebConfiguration() {
    "Enables the H2 console, for debugging. This should have an environment check on it."
    bean
    shared ServletRegistrationBean<WebServlet> h2ServletConfiguration()
            => ServletRegistrationBean<WebServlet>(WebServlet(), "/console/*");
}
