"Contains interfaces that abstract away the data layer from the rest of the application. The
 [[org.springframework.data.jpa.repository.config::enableJpaRepositories]] annotation on the
 [[demo.config::RepositoryConfiguration]] class points at this package and tells Spring to use the
 [[interop.spring::CeylonRepositoryImpl]] class to satisfy the interfaces in this package."
shared package demo.repositories;
