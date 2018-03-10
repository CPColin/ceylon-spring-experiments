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
componentScan { basePackages = ["org.thymeleaf.extras.springsecurity5"]; }
class WebConfiguration() {
    bean
    shared ServletRegistrationBean<WebServlet> h2ServletConfiguration()
            => ServletRegistrationBean<WebServlet>(WebServlet(), "/console/*");
}
