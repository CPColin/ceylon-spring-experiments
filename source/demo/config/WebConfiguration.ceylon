import org.h2.server.web {
    WebServlet
}
import org.springframework.boot.web.servlet {
    ServletRegistrationBean
}
import org.springframework.context.annotation {
    bean,
    configuration
}

configuration
class WebConfiguration() {
    bean
    shared ServletRegistrationBean<WebServlet> h2ServletConfiguration()
            => ServletRegistrationBean<WebServlet>(WebServlet(), "/console/*");
}
