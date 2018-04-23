import ceylon.time {
    YearMonth,
    yearMonth
}

import java.lang {
    JString=String,
    Types {
        nativeString
    }
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
shared class YearMonthConverter()
        satisfies AttributeConverter<YearMonth, JString> & Formatter<YearMonth> {
    shared actual JString? convertToDatabaseColumn(YearMonth? ceylonValue)
            => if (exists stringValue = print(ceylonValue, null))
                then nativeString(stringValue)
                else null;
    
    shared actual YearMonth? convertToEntityAttribute(JString? databaseValue)
            => parse(databaseValue?.string, null);
    
    shared actual YearMonth? parse(String? stringValue, Locale? locale) {
        if (exists stringValue) {
            value tokens = stringValue.split('-'.equals).sequence();
            
            if (tokens.size == 2) {
                value yearString = tokens[0];
                value monthString = tokens[1];
                
                assert (exists monthString);
                
                value year = Integer.parse(yearString);
                value month = Integer.parse(monthString);
                
                if (is Integer year, is Integer month) {
                    return yearMonth(year, month);
                }
            }
        }
        
        return null;

    }
    
    shared actual String? print(YearMonth? ceylonValue, Locale? locale) => ceylonValue?.string;
}
