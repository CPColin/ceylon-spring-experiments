import ceylon.test {
    parameters,
    test,
    assertEquals
}
import ceylon.time {
    yearMonth
}
import ceylon.time.base {
    Month,
    february,
    march,
    november
}

import interop.spring.dates {
    YearMonthConverter
}

import java.lang {
    Types {
        nativeString
    }
}

{[Integer, Month, String]*} testYearMonthParameters = {
    [2000, february, "2000-02"],
    [2010, march, "2010-03"],
    [1919, november, "1919-11"]
};

test
parameters(`value testYearMonthParameters`)
shared void testConvertYearMonth(Integer year, Month month, String stringValue) {
    value ceylonValue = yearMonth(year, month);
    value converter = YearMonthConverter();
    
    assertEquals(converter.convertToDatabaseColumn(ceylonValue), nativeString(stringValue));
    assertEquals(converter.convertToEntityAttribute(nativeString(stringValue)), ceylonValue);
}

test
parameters(`value testYearMonthParameters`)
shared void testParseAndPrintYearMonth(Integer year, Month month, String stringValue) {
    value ceylonValue = yearMonth(year, month);
    value converter = YearMonthConverter();
    
    assertEquals(converter.parse(stringValue, null), ceylonValue);
    assertEquals(converter.print(ceylonValue, null), stringValue);
}
