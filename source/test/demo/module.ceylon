import ceylon.test {
    testExtension
}

native("jvm")
testExtension(`class MySpringTestListener`)
module test.demo "1.0.0" {
	value springVersion = "5.0.4.RELEASE";
	
	import java.base "8";
	
    shared import demo "1.0.0";
    import ceylon.test "1.3.3.1";
    
    import maven:org.springframework:"spring-test" springVersion;
    import maven:org.springframework:"spring-core" springVersion;
    optional import maven:junit:"junit" "4.12";
}
