import demo.domain {
    Authority
}
import demo.util {
    CeylonRepository
}

shared interface AuthorityRepository satisfies CeylonRepository<Authority, Integer> {}
