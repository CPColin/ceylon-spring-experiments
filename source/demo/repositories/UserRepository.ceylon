import demo.domain {
    User
}
import demo.util {
    CeylonRepository
}

shared interface UserRepository satisfies CeylonRepository<User, Integer> {
    shared formal User? findByUsername(String username);
}
