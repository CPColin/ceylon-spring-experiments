import java.lang {
    Types {
        classForType
    }
}

import org.springframework.boot {
    SpringApplication
}

"Run the module `demo`."
shared void run() {
    SpringApplication.run(classForType<Application>());
}
