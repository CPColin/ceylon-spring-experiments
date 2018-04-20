import ceylon.test {
    assertEquals,
    parameters,
    test
}
import ceylon.time {
    Time,
    time
}
import ceylon.time.base {
    milliseconds
}

import interop.spring.dates {
    TimeConverter
}

import java.sql {
    JTime=Time
}

{[Integer, Integer, Integer, Integer]*} testConvertTimeParameters = {
    [0, 0, 0, 0],
    [1, 2, 3, 4],
    [12, 34, 56, 789],
    [23, 34, 45, 0],
    [23, 12, 7, 123]
};

test
parameters(`value testConvertTimeParameters`)
shared void testConvertTime(Integer hour, Integer minute, Integer second, Integer millisecond) {
    value ceylonValue = time(hour, minute, second, millisecond);
    value javaValue = JTime(
        (hour * milliseconds.perHour)
        + (minute * milliseconds.perMinute)
        + (second * milliseconds.perSecond)
        + millisecond
    );
    value converter = TimeConverter();
    
    assertEquals(converter.convertToDatabaseColumn(ceylonValue), javaValue);
    assertEquals(converter.convertToEntityAttribute(javaValue), ceylonValue);
}

{[String, Time]*} testParseAndPrintTimeParameters = {
    ["10:00:00.000", time(10, 0, 0, 0)],
    ["12:34:56.789", time(12, 34, 56, 789)]
};

test
parameters(`value testParseAndPrintTimeParameters`)
shared void testParseAndPrintTime(String stringValue, Time ceylonValue) {
    value converter = TimeConverter();
    
    assertEquals(converter.parse(stringValue, null), ceylonValue);
    assertEquals(converter.print(ceylonValue, null), stringValue);
}

"Tests the special case for the end-of-day value `24:00:00`."
test
shared void testParseEndOfDayTime() {
    assertEquals(TimeConverter().parse("24:00:00", null), time(00, 00));
}
