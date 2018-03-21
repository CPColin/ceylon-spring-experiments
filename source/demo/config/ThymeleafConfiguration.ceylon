import org.springframework.context.annotation {
    bean,
    configuration
}
import org.thymeleaf.extras.springsecurity4.dialect {
    SpringSecurityDialect
}

configuration
class ThymeleafConfiguration() {
    "We have to specify the dialect manually because the default configuration targets the
     `springsecurity4` package and doesn't know about version 5 yet."
    bean
    shared SpringSecurityDialect securityDialect() => SpringSecurityDialect();
}
