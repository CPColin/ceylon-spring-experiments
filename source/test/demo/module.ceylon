import ceylon.test {
    testExtension
}

native("jvm")
testExtension(`class SpringTestListener`)
module test.demo "1.0.0" {
    value springVersion = "5.0.4.RELEASE";
    
    import java.base "8";
    
    shared import demo "1.0.0";
    
    import ceylon.interop.java "1.3.3";
    import ceylon.test "1.3.3.1";
    
    import maven:org.springframework:"spring-test" springVersion;
}
