import ceylon.test {
    TestDescription,
    TestListener
}
import ceylon.test.event {
    TestAbortedEvent,
    TestFinishedEvent,
    TestRunFinishedEvent,
    TestRunStartedEvent,
    TestSkippedEvent,
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
    
    variable Object? instance = null;
    variable Method? method = null;
    
    "The documentation for [[TestContextManager]] says to have its functions execute before any
     other similar before- or after-test functions run. This arbitrary value might help."
    shared actual Integer order => -100;
    
    shared actual void testRunStarted(TestRunStartedEvent event) {
        testContextManager = TestContextManager(classForInstance(this));
        testContextManager.beforeTestClass();
    }
    
    shared actual void testStarted(TestStartedEvent event) {
        if (exists instance = event.instance) {
            this.instance = instance;
            
            testContextManager.prepareTestInstance(instance);
            
            if (exists method = findMethod(instance, event.description)) {
                this.method = method;
                
                testContextManager.beforeTestMethod(instance, method);
            }
        }
    }
    
    shared actual void testFinished(TestFinishedEvent event) {
        if (exists instance = this.instance, exists method = this.method) {
            testContextManager.afterTestMethod(instance, method, event.result.exception);
        }
        
        this.instance = null;
        this.method = null;
    }
    
    shared actual void testAborted(TestAbortedEvent event) {
        if (exists instance = this.instance, exists method = this.method) {
            testContextManager.afterTestMethod(instance, method, event.result.exception);
            
            this.instance = null;
            this.method = null;
        }
    }
    
    shared actual void testSkipped(TestSkippedEvent event) {
        if (exists instance = this.instance, exists method = this.method) {
            testContextManager.afterTestMethod(instance, method, event.result.exception);
            
            this.instance = null;
            this.method = null;
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
