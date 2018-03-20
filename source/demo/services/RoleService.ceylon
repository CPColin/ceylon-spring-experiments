import demo.domain {
    Role
}

shared interface RoleService satisfies CrudService<Role> {}
