import demo.domain {
    User
}

shared interface UserService satisfies CrudService<User> {
    shared formal User? findByUserName(String userName);
}
