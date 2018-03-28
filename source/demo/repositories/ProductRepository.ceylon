import demo.domain {
    Product
}

import interop.spring {
    CeylonRepository
}

shared interface ProductRepository satisfies CeylonRepository<Product, Integer> {}