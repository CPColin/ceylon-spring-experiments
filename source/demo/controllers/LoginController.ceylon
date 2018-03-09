import org.springframework.stereotype {
    controller
}
import org.springframework.web.bind.annotation {
    requestMapping
}

controller
class LoginController() {
    requestMapping(["/login"])
    shared String login() => "login";
}
