import demo.domain {
    Product
}

shared interface ProductService satisfies CrudService<Product> {}
