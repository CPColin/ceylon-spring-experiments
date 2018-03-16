import demo.domain {
    User
}

shared interface UserService satisfies CrudService<User> {
    shared formal User? findByUserName(String userName);
    
    shared formal void setPassword(User user, String plainTextPassword);
}
