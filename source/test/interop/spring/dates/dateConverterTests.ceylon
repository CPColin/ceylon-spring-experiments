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

import java.sql {
    JDate=Date
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

{[Integer, Month, Integer, Integer]*} testConvertDateParameters = {
    [2000, january, Calendar.january, 1],
    [2000, february, Calendar.february, 1],
    [2000, february, Calendar.february, 29],
    [2000, december, Calendar.december, 31]
};

test
parameters(`value testConvertDateParameters`)
shared void testConvertDate(Integer year, Month ceylonMonth, Integer javaMonth, Integer day) {
    value ceylonValue = date(year, ceylonMonth, day);
    value calendar = GregorianCalendar(year, javaMonth, day);
    value javaValue = JDate(calendar.time.time);
    value converter = DateConverter();
    
    assertEquals(converter.convertToDatabaseColumn(ceylonValue), javaValue);
    assertEquals(converter.convertToEntityAttribute(javaValue), ceylonValue);
}

{[String, Date]*} testParseAndPrintDateParameters = {
    ["2000-01-01", date(2000, january, 1)],
    ["2000-02-01", date(2000, february, 1)],
    ["2000-02-29", date(2000, february, 29)],
    ["2000-12-31", date(2000, december, 31)]
};

test
parameters(`value testParseAndPrintDateParameters`)
shared void testParseAndPrintDate(String stringValue, Date ceylonValue) {
    value converter = DateConverter();
    
    assertEquals(converter.parse(stringValue, null), ceylonValue);
    assertEquals(converter.print(ceylonValue, null), stringValue);
}
