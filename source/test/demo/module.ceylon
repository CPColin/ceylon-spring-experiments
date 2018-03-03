import ceylon.test {
    testExtension
}

native("jvm")
testExtension(`class MySpringTestListener`)
module test.demo "1.0.0" {
	import java.base "8";
	
    shared import demo "1.0.0";
    import ceylon.test "1.3.3.1";
    
    import maven:org.springframework:"spring-test" "4.3.14.RELEASE";
    import maven:org.springframework:"spring-core" "4.3.14.RELEASE";
    optional import maven:junit:"junit" "4.12";
}
