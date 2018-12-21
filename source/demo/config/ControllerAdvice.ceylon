import org.springframework.web.bind {
    WebDataBinder
}
import org.springframework.web.bind.annotation {
    controllerAdvice,
    initBinder
}

controllerAdvice
class ControllerAdvice() {
    "Set the data binder to default to accessing fields directly, so we don't have to make our
     entities' fields `variable`."
    initBinder
    shared void initBinder(WebDataBinder binder) {
        binder.initDirectFieldAccess();
    }
}
