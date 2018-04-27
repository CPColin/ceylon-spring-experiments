import ceylon.time {
    DateTime,
    dateTime
}
import ceylon.time.iso8601 {
    parseDateTime
}

import java.util {
    Calendar,
    GregorianCalendar,
    JDate=Date,
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

"Converts a Ceylon [[DateTime]] to a Java [[JDate]], without any timezone conversion."
component
converter { autoApply=true; }
shared class DateTimeConverter()
        satisfies AttributeConverter<DateTime, JDate> & Formatter<DateTime> {
    shared actual JDate? convertToDatabaseColumn(DateTime? ceylonValue) {
        if (exists ceylonValue) {
            value calendar = GregorianCalendar();
            
            calendar.set(Calendar.year, ceylonValue.year);
            calendar.set(Calendar.month, ceylonValue.month.integer - 1);
            calendar.set(Calendar.dayOfMonth, ceylonValue.day);
            calendar.set(Calendar.hourOfDay, ceylonValue.hours);
            calendar.set(Calendar.minute, ceylonValue.minutes);
            calendar.set(Calendar.second, ceylonValue.seconds);
            calendar.set(Calendar.millisecond, ceylonValue.milliseconds);
            
            return calendar.time;
        } else {
            return null;
        }
    }
    
    shared actual DateTime? convertToEntityAttribute(JDate? databaseValue) {
        if (exists databaseValue) {
            value calendar = GregorianCalendar();
            
            calendar.time = databaseValue;
            
            return dateTime {
                year = calendar.get(Calendar.year);
                month = calendar.get(Calendar.month) + 1;
                day = calendar.get(Calendar.dayOfMonth);
                hours = calendar.get(Calendar.hourOfDay);
                minutes = calendar.get(Calendar.minute);
                seconds = calendar.get(Calendar.second);
                milliseconds = calendar.get(Calendar.millisecond);
            };
        } else {
            return null;
        }
    }
    
    shared actual DateTime? parse(String? stringValue, Locale? locale)
            => if (exists stringValue)
                then parseDateTime(stringValue)
                else null;
    
    shared actual String? print(DateTime? ceylonValue, Locale? locale) => ceylonValue?.string;
}
