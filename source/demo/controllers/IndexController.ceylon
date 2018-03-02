import org.springframework.stereotype {
    controller
}
import org.springframework.web.bind.annotation {
    requestMapping
}

controller
class IndexController() {
    requestMapping(["/"])
    shared String index() {
        return "index";
    }
}
