import demo.domain {
    Authority
}

import interop.spring {
    CeylonRepository
}

shared interface AuthorityRepository satisfies CeylonRepository<Authority, Integer> {}
