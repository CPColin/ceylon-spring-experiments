import demo.domain {
    User
}

import interop.spring {
    CeylonRepository
}

shared interface UserRepository satisfies CeylonRepository<User, Integer> {
    shared formal User? findByUsername(String username);
}
