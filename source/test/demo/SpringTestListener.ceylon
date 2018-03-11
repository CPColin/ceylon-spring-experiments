import demo {
    Application
}

import org.springframework.test.context {
    contextConfiguration
}

"Spring needs to know whose configuration we want to use while testing, so we extend the abstract
 listener, annotate it appropriately, then annotate the package or module with this class as a
 [[ceylon.test::testExtension]]."
contextConfiguration { classes = [`Application`]; }
class SpringTestListener() extends AbstractSpringTestListener() {}
