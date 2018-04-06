import ceylon.interop.java {
    JavaIterable
}
import ceylon.language.meta {
    classDeclaration
}
import ceylon.language.meta.model {
    ClassOrInterface,
    Type
}

import java.lang {
    JIterable=Iterable,
    JLong=Long,
    JString=String,
    Types {
        nativeString
    }
}
import java.util {
    Locale
}

import javax.persistence {
    AttributeConverter
}

import org.springframework.format {
    Formatter
}

shared abstract class EnumeratedColumn<DatabaseType>(shared DatabaseType databaseValue)
        given DatabaseType satisfies Object {
    shared actual default String string => "``classDeclaration(this).name``-``databaseValue``";
}

shared abstract class EnumeratedIntegerColumn(Integer databaseValue)
        extends EnumeratedColumn<Integer>(databaseValue) {}

shared abstract class EnumeratedStringColumn(String databaseValue)
        extends EnumeratedColumn<String>(databaseValue) {}

"Returns the [[EntityType]] value that matches the given [[attribute]], if any."
EntityType? findEntityValue<EntityType, DatabaseType>(DatabaseType attribute)
        given EntityType satisfies EnumeratedColumn<DatabaseType>
        given DatabaseType satisfies Object
        => cvalues(`EntityType`).find((entity) => entity.databaseValue == attribute);

"Returns all the values for the given [[entityType]] in a Ceylon [[Iterable]]."
shared {EntityType*} cvalues<EntityType>(Type<EntityType> entityType) {
    assert (is ClassOrInterface<EntityType> entityType);
    
    return entityType.caseValues;
}

"Returns all the values for the given [[entityType]] in a Java [[JIterable]]."
shared JIterable<EntityType> jvalues<EntityType>(Type<EntityType> entityType) {
    return JavaIterable(cvalues(entityType));
}

"Converts between [[EntityType]] instances that intend to use ID's with [[CeylonType]] in Ceylon
 code and [[DatabaseType]] in the database."
shared abstract class EnumeratedColumnConverter<EntityType, CeylonType, DatabaseType>()
        satisfies AttributeConverter<EntityType, DatabaseType> & Formatter<EntityType>
        given EntityType satisfies EnumeratedColumn<CeylonType>
        given CeylonType satisfies Object
        given DatabaseType satisfies Object {
    "Converts the given [[ceylonValue]] to a [[DatabaseType]] value. Inverse of [[databaseToCeylon]]."
    shared formal DatabaseType ceylonToDatabase(CeylonType ceylonValue);
    
    "Converts the given [[databaseValue]] to a [[CeylonType]] value. Inverse of [[ceylonToDatabase]]."
    shared formal CeylonType databaseToCeylon(DatabaseType databaseValue);
    
    "Converts the given [[stringValue]] to a [[CeylonType]] value, if possible."
    shared formal CeylonType? stringToCeylon(String stringValue);
    
    "Converts the given [[entityValue]] to a [[DatabaseType]] value, for storage in the database.
     Inverse of [[convertToEntityAttribute]]."
    shared actual DatabaseType? convertToDatabaseColumn(EntityType? entityValue)
            => if (exists entityValue) then ceylonToDatabase(entityValue.databaseValue) else null;
    
    "Converts the given [[databaseValue]] to an equivalent [[EntityType]] value, if possible.
     Inverse of [[convertToDatabaseColumn]]."
    shared actual EntityType? convertToEntityAttribute(DatabaseType? databaseValue)
            => if (exists databaseValue)
                then findEntityValue<EntityType, CeylonType>(databaseToCeylon(databaseValue))
                else null;
    
    "Converts the given [[stringValue]] to an equivalent [[EntityType]] value, if possible. Inverse
     of [[print]]."
    shared actual EntityType? parse(String? stringValue, Locale locale)
            => if (exists stringValue, is CeylonType ceylonValue = stringToCeylon(stringValue))
                then findEntityValue<EntityType, CeylonType>(ceylonValue)
                else null;
    
    "Converts the given [[entityValue]] to a Ceylon [[String]]. Inverse of [[parse]]."
    shared actual String? print(EntityType? entityValue, Locale locale)
            => if (exists entityValue) then entityValue.databaseValue.string else null;
}

"A converter between [[EntityType]]s that use [[Integer]] ID's and database tables that use
 [[JLong]]s."
shared abstract class EnumeratedIntegerColumnConverter<EntityType>()
        extends EnumeratedColumnConverter<EntityType, Integer, JLong>()
        given EntityType satisfies EnumeratedColumn<Integer> {
    shared actual JLong ceylonToDatabase(Integer ceylonValue) => JLong(ceylonValue);
    
    shared actual Integer databaseToCeylon(JLong databaseValue) => databaseValue.longValue();
    
    shared actual Integer? stringToCeylon(String stringValue)
            => if (is Integer ceylonValue = Integer.parse(stringValue))
                then ceylonValue
                else null;
}

"A converter between [[EntityType]]s that use [[String]] ID's and database tables that use
 [[JString]]s."
shared abstract class EnumeratedStringColumnConverter<EntityType>()
        extends EnumeratedColumnConverter<EntityType, String, JString>()
        given EntityType satisfies EnumeratedColumn<String> {
    shared actual JString ceylonToDatabase(String ceylonValue) => nativeString(ceylonValue);
    
    shared actual String databaseToCeylon(JString databaseValue) => databaseValue.string;
    
    shared actual String stringToCeylon(String stringValue) => stringValue;
}
