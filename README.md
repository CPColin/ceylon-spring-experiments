# ceylon-spring-experiments

Let's smush Ceylon, Spring Boot, and Thymeleaf together and see what happens!

## Important configuration options

See `.ceylon/config` for important configuration options, notably:

   - We might not _have_ to use the compiler's "EE Mode," but it's nice not having to annotate all
     our methods `default` just to keep the `final` modifier out of the generated classes.
   - Automatically and fully exporting Maven dependencies makes sure that the dependencies brought
     in by the Spring Starter modules make it onto the classpath.
   - Using a flat classpath lets Spring do its stuff without Ceylon's usual module management
     getting in its way.

## Thymeleaf

As of this writing, there's no `thymeleas-extras-springsecurity5` module available, because
Spring 5 is still pretty new. I made one and put it on my GitHub
[here](https://github.com/CPColin/thymeleaf-extras-springsecurity). Clone that repository and do a
`mvn install` in the `thymeleaf-extra-springsecurity5` directory to install the module into your
local repository.

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
