import ceylon.test {
    assertEquals,
    assumeFalse,
    test
}
import ceylon.time {
    now
}
import ceylon.time.timezone {
    timeZone
}

import interop.spring.dates {
    InstantConverter
}

import java.text {
    SimpleDateFormat
}
import java.util {
    JDate=Date
}

String iso8601DateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

void assumeSystemTimeZoneIsNotUtc() {
    assumeFalse(timeZone.system.offsetMilliseconds == timeZone.utc.offsetMilliseconds,
        "This test is only meaningful when the current timezone does not match UTC.");
}

test
shared void testConvertInstantToDate() {
    assumeSystemTimeZoneIsNotUtc();
    
    value ceylonValue = now();
    value javaValue = InstantConverter().convertToDatabaseColumn(ceylonValue);
    value formatted = SimpleDateFormat(iso8601DateFormat).format(javaValue);
    
    assertEquals(formatted, ceylonValue.string);
}

test
shared void testConvertDateToInstant() {
    assumeSystemTimeZoneIsNotUtc();
    
    value javaValue = JDate(now().millisecondsOfEpoch);
    value ceylonValue = InstantConverter().convertToEntityAttribute(javaValue);
    value formatted = SimpleDateFormat(iso8601DateFormat).format(javaValue);
    
    assertEquals(formatted, ceylonValue?.string);
}
