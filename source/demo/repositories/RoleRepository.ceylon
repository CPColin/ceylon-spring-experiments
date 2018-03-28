import demo.domain {
    Role
}

import interop.spring {
    CeylonRepository
}

shared interface RoleRepository satisfies CeylonRepository<Role, Integer> {}
