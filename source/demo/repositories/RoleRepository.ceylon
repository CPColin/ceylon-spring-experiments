import demo.domain {
    Role
}
import demo.util {
    CeylonRepository
}

shared interface RoleRepository satisfies CeylonRepository<Role, Integer> {}
