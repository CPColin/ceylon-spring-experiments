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

"A converter between [[EntityType]]s that use [[Integer]]s and database tables that use [[JLong]]s."
shared abstract class EnumeratedIntegerColumnConverter<EntityType>()
        satisfies AttributeConverter<EntityType, JLong> & Formatter<EntityType>
        given EntityType satisfies EnumeratedIntegerColumn {
    shared actual JLong? convertToDatabaseColumn(EntityType? attribute)
            => if (exists attribute) then JLong(attribute.databaseValue) else null;
    
    shared actual EntityType? convertToEntityAttribute(JLong? attribute)
            => if (exists attribute) then findEntityValue<EntityType, Integer>(attribute.longValue()) else null;
    
    shared actual EntityType? parse(String? text, Locale locale)
            => if (exists text, is Integer longValue = Integer.parse(text))
                then convertToEntityAttribute(JLong(longValue))
                else null;
    
    shared actual String? print(EntityType? entity, Locale locale)
            => convertToDatabaseColumn(entity)?.string;
}

"A converter between [[EntityType]]s that use [[String]]s and database tables that use [[JString]]s."
shared abstract class EnumeratedStringColumnConverter<EntityType>()
        satisfies AttributeConverter<EntityType, JString> & Formatter<EntityType>
        given EntityType satisfies EnumeratedStringColumn {
    shared actual JString? convertToDatabaseColumn(EntityType? attribute)
            => if (exists attribute) then nativeString(attribute.databaseValue) else null;
    
    shared actual EntityType? convertToEntityAttribute(JString? attribute)
            => if (exists attribute) then findEntityValue<EntityType, String>(attribute.string) else null;
    
    shared actual EntityType? parse(String? text, Locale locale)
            => if (exists text) then convertToEntityAttribute(nativeString(text)) else null;
    
    shared actual String? print(EntityType? entity, Locale locale)
            => convertToDatabaseColumn(entity)?.string;
}
