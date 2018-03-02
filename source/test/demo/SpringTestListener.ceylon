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

import demo {
	Application
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
	TestContextManager,
	contextConfiguration
}

abstract class AbstractSpringTestListener() satisfies TestListener {
	late TestContextManager testContextManager;
	
	order => -100;
	
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

contextConfiguration { classes = [`Application`]; }
class MySpringTestListener() extends AbstractSpringTestListener() {}
