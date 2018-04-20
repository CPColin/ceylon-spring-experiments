import ceylon.time {
    Time,
    time
}
import ceylon.time.base {
    milliseconds
}
import ceylon.time.iso8601 {
    parseTime
}

import java.sql {
    JTime=Time
}
import java.time {
    LocalTime
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
    shared actual JTime? convertToDatabaseColumn(Time? ceylonValue) {
        if (exists ceylonValue) {
            value databaseValue = JTime.valueOf(LocalTime.\iof(
                ceylonValue.hours,
                ceylonValue.minutes,
                ceylonValue.seconds));
            
            // JTime.valueOf() ignores milliseconds, so we have to add them ourselves.
            databaseValue.time += ceylonValue.milliseconds;
            
            return databaseValue;
        } else {
            return null;        
        }
    }
    
    shared actual Time? convertToEntityAttribute(JTime? databaseValue)
            => if (exists databaseValue, exists localTime = databaseValue.toLocalTime())
                then time(
                    localTime.hour,
                    localTime.minute,
                    localTime.second,
                    // JTime.toLocalTime() omits milliseconds, so we have to get them ourselves.
                    databaseValue.time % milliseconds.perSecond)
                else null;
    
    shared actual Time? parse(String? stringValue, Locale? locale)
            => if (exists stringValue)
                then parseTime(stringValue)
                else null;
    
    shared actual String? print(Time? ceylonValue, Locale? locale) => ceylonValue?.string;
}
