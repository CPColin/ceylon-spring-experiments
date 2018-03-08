import demo.util {
    CeylonRepository
}

import demo.domain {
    Product
}

shared interface ProductRepository satisfies CeylonRepository<Product, Integer> {}