import ceylon.test {
    assertEquals,
    parameters,
    test
}
import ceylon.time {
    Date,
    date
}
import ceylon.time.base {
    Month,
    january,
    february,
    december
}

import interop.spring.dates {
    DateConverter
}

import java.util {
    Calendar,
    GregorianCalendar
}

{[Integer, Integer, String]*} testFormatDigitsParameters = {
    [0, 2, "00"],
    [1, 2, "01"],
    [10, 2, "10"],
    [100, 2, "100"],
    [100, 4, "0100"],
    [1000, 4, "1000"]
};

test
parameters(`value testFormatDigitsParameters`)
shared void testFormatDigits(Integer val, Integer digits, String expected) {
    assertEquals(DateConverter.formatDigits(val, digits), expected);
}

{[Integer, Month, Integer, Integer]*} testConvertToAndFromParameters = {
    [2000, january, Calendar.january, 1],
    [2000, february, Calendar.february, 1],
    [2000, february, Calendar.february, 29],
    [2000, december, Calendar.december, 31]
};

test
parameters(`value testConvertToAndFromParameters`)
shared void testConvertToAndFrom(Integer year, Month ceylonMonth, Integer javaMonth, Integer day) {
    value ceylonDate = date(year, ceylonMonth, day);
    value calendar = GregorianCalendar(year, javaMonth, day);
    value javaDate = calendar.time;
    value converter = DateConverter();
    
    assertEquals(converter.convertToDatabaseColumn(ceylonDate), javaDate);
    assertEquals(converter.convertToEntityAttribute(javaDate), ceylonDate);
}

{[String, Date]*} testParseAndPrintParameters = {
    ["2000-01-01", date(2000, january, 1)],
    ["2000-02-01", date(2000, february, 1)],
    ["2000-02-29", date(2000, february, 29)],
    ["2000-12-31", date(2000, december, 31)]
};

test
parameters(`value testParseAndPrintParameters`)
shared void testParseAndPrint(String stringValue, Date ceylonValue) {
    value converter = DateConverter();
    
    assertEquals(converter.parse(stringValue, null), ceylonValue);
    assertEquals(converter.print(ceylonValue, null), stringValue);
}
