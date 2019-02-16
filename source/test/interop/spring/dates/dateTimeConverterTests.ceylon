import ceylon.test {
    assertEquals,
    ignore,
    parameters,
    test
}
import ceylon.time {
    DateTime,
    dateTime
}
import ceylon.time.base {
    Month,
    february,
    january,
    october
}

import interop.spring.dates {
    DateTimeConverter
}

import java.sql {
    JDate=Date
}
import java.util {
    Calendar,
    GregorianCalendar
}

{[Integer, Month, Integer, Integer, Integer, Integer, Integer, Integer]*}
testConvertDateTimeParameters = {
    [2000, january, Calendar.january, 10, 22, 33, 44, 555],
    [2000, february, Calendar.february, 29, 12, 34, 56, 789]
};

test
parameters(`value testConvertDateTimeParameters`)
shared void testConvertDateTime(Integer year, Month ceylonMonth, Integer javaMonth, Integer day,
        Integer hour, Integer minute, Integer second, Integer millisecond) {
    value ceylonValue = dateTime(year, ceylonMonth, day, hour, minute, second, millisecond);
    value calendar = GregorianCalendar(year, javaMonth, day, hour, minute, second);
    
    calendar.set(Calendar.millisecond, millisecond);
    
    value javaValue = JDate(calendar.time.time);
    value converter = DateTimeConverter();
    
    assertEquals(converter.convertToDatabaseColumn(ceylonValue), javaValue);
    assertEquals(converter.convertToEntityAttribute(javaValue), ceylonValue);
}

{[String, DateTime, String]*} testParseAndPrintDateTimeParameters = {
    ["2000-01-01T00", dateTime(2000, january, 1, 0, 0, 0, 0), "2000-01-01T00:00:00.000"],
    ["2000-01-01T00:00", dateTime(2000, january, 1, 0, 0, 0, 0), "2000-01-01T00:00:00.000"],
    ["2000-01-01T00:00:00", dateTime(2000, january, 1, 0, 0, 0, 0), "2000-01-01T00:00:00.000"],
    ["2000-02-29T00:00:00", dateTime(2000, february, 29, 0, 0, 0, 0), "2000-02-29T00:00:00.000"],
    ["2000-10-13T12:34:56.789", dateTime(2000, october, 13, 12, 34, 56, 789), "2000-10-13T12:34:56.789"],
    ["2010-02-14T24:00:00", dateTime(2010, february, 15, 0, 0, 0, 0), "2010-02-15T00:00:00.000"]
};

test
ignore("See https://github.com/eclipse/ceylon-sdk/issues/705")
parameters(`value testParseAndPrintDateTimeParameters`)
shared void testParseAndPrintDateTime(String parseValue, DateTime ceylonValue, String printValue) {
    value converter = DateTimeConverter();
    
    assertEquals(converter.parse(parseValue, null), ceylonValue);
    assertEquals(converter.print(ceylonValue, null), printValue);
}
