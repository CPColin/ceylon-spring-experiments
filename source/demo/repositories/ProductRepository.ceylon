import ceylon.interop.spring {
    CeylonRepository
}

import demo.domain {
    Product
}

shared interface ProductRepository satisfies CeylonRepository<Product, Integer> {}