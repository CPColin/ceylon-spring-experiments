import ceylon.time {
    Instant
}
import ceylon.time.timezone {
    timeZone,
    zoneDateTime
}

import java.util {
    Calendar,
    GregorianCalendar,
    JDate=Date
}

import javax.persistence {
    AttributeConverter,
    converter
}

import org.springframework.stereotype {
    component
}

"Converts a Ceylon [[Instant]] to a Java [[JDate]] with its timezone set to UTC."
component
converter { autoApply = true; }
shared class InstantConverter()
        satisfies AttributeConverter<Instant, JDate> {
    shared actual JDate? convertToDatabaseColumn(Instant? ceylonValue) {
        if (exists ceylonValue) {
            value zoneDateTime = ceylonValue.zoneDateTime(timeZone.utc);
            value calendar = GregorianCalendar(zoneDateTime.year, zoneDateTime.month.integer - 1,
                zoneDateTime.day, zoneDateTime.hours, zoneDateTime.minutes, zoneDateTime.seconds);
            
            calendar.set(Calendar.millisecond, zoneDateTime.milliseconds);
            
            return calendar.time;
        } else {
            return null;
        }
    }
    
    shared actual Instant? convertToEntityAttribute(JDate? databaseValue) {
        if (exists databaseValue) {
            value calendar = GregorianCalendar();
            
            calendar.time = databaseValue;
            
            return zoneDateTime {
                timeZone = timeZone.utc;
                year = calendar.get(Calendar.year);
                month = calendar.get(Calendar.month) + 1;
                date = calendar.get(Calendar.dayOfMonth);
                hour = calendar.get(Calendar.hourOfDay);
                minutes = calendar.get(Calendar.minute);
                seconds = calendar.get(Calendar.second);
                millis = calendar.get(Calendar.millisecond);
            }.instant;
        } else {
            return null;
        }
    }
    
    //shared actual Instant? parse(String? stringValue, Locale? locale)
    //        => if (exists stringValue)
    //            then parseZoneDateTime(stringValue)?.instant
    //            else null;
    //
    //shared actual String? print(Instant? ceylonValue, Locale? locale) => ceylonValue?.string;
}
