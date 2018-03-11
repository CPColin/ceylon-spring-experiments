import ceylon.test {
    TestDescription,
    TestListener
}
import ceylon.test.event {
    TestFinishedEvent,
    TestRunFinishedEvent,
    TestRunStartedEvent,
    TestStartedEvent
}

import java.lang {
    Types {
        classForInstance
    }
}
import java.lang.reflect {
    Method
}

import org.springframework.test.context {
    TestContextManager
}

"Bridges the divide between [[module ceylon.test]] and the Spring Framework by manually triggering
 things like dependency injection at (what seem to be) the right times."
abstract class AbstractSpringTestListener() satisfies TestListener {
    late TestContextManager testContextManager;
    
    "The documentation for [[TestContextManager]] says to have its functions execute before any
     other similar before- or after-test functions run. This arbitrary value might help."
    shared actual Integer order => -100;
    
    shared actual void testRunStarted(TestRunStartedEvent event) {
        testContextManager = TestContextManager(classForInstance(this));
        testContextManager.beforeTestClass();
    }
    
    shared actual void testStarted(TestStartedEvent event) {
        if (exists instance = event.instance) {
            testContextManager.prepareTestInstance(instance);
            
            if (exists method = findMethod(instance, event.description)) {
                testContextManager.beforeTestMethod(instance, method);
            }
        }
    }
    
    shared actual void testFinished(TestFinishedEvent event) {
        if (exists instance = event.instance,
            exists method = findMethod(instance, event.result.description)) {
            testContextManager.afterTestMethod(instance, method, event.result.exception);
        }
    }
    
    shared actual void testRunFinished(TestRunFinishedEvent event) {
        testContextManager.afterTestClass();
    }
    
    "Returns a [[Method]] in the given [[instance]] that matches the function named in the given
     [[description]], without caring about the parameter list or return type. The assumption is that
     there's only gonig to be one, since we're working with an instance of a Ceylon class."
    Method? findMethod(Object instance, TestDescription description) {
        if (exists functionDeclaration = description.functionDeclaration) {
            value clazz = classForInstance(instance);
            
            for (value method in clazz.methods) {
                if (method.name == functionDeclaration.name) {
                    return method;
                }
            }
        }
        
        return null;
    }
}
