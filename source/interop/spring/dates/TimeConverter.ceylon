import ceylon.time {
    Time
}
import ceylon.time.internal {
    TimeOfDay
}
import ceylon.time.iso8601 {
    parseTime
}

import java.sql {
    JTime=Time
}
import java.util {
    Locale
}

import javax.persistence {
    AttributeConverter,
    converter
}

import org.springframework.format {
    Formatter
}
import org.springframework.stereotype {
    component
}

component
converter { autoApply = true; }
shared class TimeConverter()
        satisfies AttributeConverter<Time, JTime> & Formatter<Time> {
    shared actual JTime? convertToDatabaseColumn(Time? ceylonValue)
            => if (exists ceylonValue)
                then JTime(ceylonValue.millisecondsOfDay)
                else null;
    
    shared actual Time? convertToEntityAttribute(JTime? databaseValue)
            => if (exists databaseValue)
                then TimeOfDay(databaseValue.time)
                else null;
    
    shared actual Time? parse(String? stringValue, Locale? locale)
            => if (exists stringValue)
                then parseTime(stringValue)
                else null;
    
    shared actual String? print(Time? ceylonValue, Locale? locale) => ceylonValue?.string;
}
