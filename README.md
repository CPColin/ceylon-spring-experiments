# ceylon-spring-experiments

Let's smush Ceylon, Spring Boot, and Thymeleaf together and see what happens!

Run the `demo::run` function to fire up a server on `localhost:8080` and experiment with the simple
CRUD webapp. Log in as `admin1` or `admin2` to get elevated privileges or anybody between `user1`
and `user5` to get normal privileges.

## Fun stuff

   - Look how clean `demo.domain::Product` is! Since Ceylon takes care of the getters and setters
     for us, we can just annotate our attributes `variable` and we're good to go.
   - By annotating `demo.services.impl::CrudServiceImpl.repository` with `formal`, we enforce the
     contract that each class in `demo.services.impl` must specify which repository interface it's
     going to use while also being able to provide default implementations of some common tasks.

## Important configuration options

See `.ceylon/config` for important configuration options, notably:

   - We might not _have_ to use the compiler's "EE Mode," but it's nice not having to annotate all
     our methods `default` just to keep the `final` modifier out of the generated classes.
   - Automatically and fully exporting Maven dependencies makes sure that the dependencies brought
     in by the Spring Starter modules make it onto the classpath.
   - Using a flat classpath lets Spring do its stuff without Ceylon's usual module management
     getting in its way.

## Thymeleaf

You can find the Thymeleaf templates in the `resource/demo/ROOT/templates/fragments` directory.
They use an unusual, inside-out layout pattern I like, where, instead of having to keep the page
structure consistent between templates, having to remember to include the header and footer
fragments, etc., templates pass themselves to the Layout fragment, which turns around and inserts
the content where it needs to go. The `Layout.js` script handles jumping through the right hoops to
keep such templates looking natural. If you're using Chrome, please see the note in that file,
because you'll need a certain command-line option in order for this trick to work.

## Inspirations

Thanks to the following for inspiring this experiment and providing example code that helped me
figure out how this stuff fits together:

   - https://springframework.guru/spring-boot-web-application-part-2-using-thymeleaf/
   - https://github.com/lucono/ceylon-springboot-demo
   - https://github.com/DiegoCoronel/ceylon-spring-boot
