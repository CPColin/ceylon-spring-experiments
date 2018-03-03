import demo.domain {
    User
}
import demo.repositories {
    UserRepository
}

import org.springframework.boot {
    ApplicationRunner,
    ApplicationArguments
}
import org.springframework.boot.autoconfigure {
    springBootApplication
}
import org.springframework.context.annotation {
    bean
}

springBootApplication
shared class Application() {
    bean
    shared ApplicationRunner runner(UserRepository users)
            => object satisfies ApplicationRunner {
        shared actual void run(ApplicationArguments? args) {
            users.save(User("name"));
            print(users.findAll());
        }
    };
}
