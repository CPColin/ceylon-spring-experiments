import ceylon.time {
    Date,
    date
}

import java.sql {
    JDate=Date
}
import java.util {
    Calendar,
    GregorianCalendar,
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
shared class DateConverter
        satisfies AttributeConverter<Date, JDate> & Formatter<Date> {
    static shared String formatDigits(Integer val, Integer digits)
            => val.string.padLeading(digits, '0');
    
    shared new() {}
    
    shared actual JDate? convertToDatabaseColumn(Date? ceylonValue) {
        if (exists ceylonValue) {
            value calendar = GregorianCalendar(
                ceylonValue.year,
                ceylonValue.month.integer - 1,
                ceylonValue.day);
            
            return JDate(calendar.time.time);
        } else {
            return null;
        }
    }
    
    shared actual Date? convertToEntityAttribute(JDate? databaseValue) {
        if (exists databaseValue) {
            value calendar = GregorianCalendar();
            
            calendar.time = databaseValue;
            
            return date(
                calendar.get(Calendar.year),
                calendar.get(Calendar.month) + 1,
                calendar.get(Calendar.dayOfMonth));
        } else {
            return null;
        }
    }
    
    // TODO: Use ceylon.time.iso8601::parseDate when eclipse/ceylon-sdk#705 is fixed.
    shared actual Date? parse(String? stringValue, Locale? locale) {
        if (exists stringValue) {
            value tokens = stringValue.split('-'.equals).sequence();
            
            if (tokens.size != 3) {
                return null;
            }
            
            value yearString = tokens[0];
            value monthString = tokens[1];
            value dayString = tokens[2];
            
            if (exists monthString, exists dayString) {
                value year = Integer.parse(yearString);
                value month = Integer.parse(monthString);
                value day = Integer.parse(dayString);
                
                if (is Integer year, is Integer month, is Integer day) {
                    return date(year, month, day);
                }
            }
        }
        
        return null;
    }
    
    shared actual String? print(Date? ceylonValue, Locale? locale)
            => if (exists ceylonValue)
                then ceylonValue.string
                else null;
}
