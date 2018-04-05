import ceylon.language.meta {
    classDeclaration
}
import ceylon.language.meta.model {
    ClassOrInterface
}

import java.lang {
    JLong=Long,
    JString=String,
    Types {
        nativeString
    }
}

import javax.persistence {
    AttributeConverter
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
        given DatabaseType satisfies Object {
    value entityType = `EntityType`;
    
    assert (is ClassOrInterface<EntityType> entityType);
    
    return entityType.caseValues.find((entity) => entity.databaseValue == attribute);
}

"A converter between [[EntityType]]s that use [[Integer]]s and database tables that use [[JLong]]s."
shared abstract class EnumeratedIntegerColumnConverter<EntityType>()
        satisfies AttributeConverter<EntityType, JLong>
        given EntityType satisfies EnumeratedIntegerColumn {
    shared actual JLong? convertToDatabaseColumn(EntityType? attribute)
            => if (exists attribute) then JLong(attribute.databaseValue) else null;
    
    shared actual EntityType? convertToEntityAttribute(JLong? attribute)
            => if (exists attribute) then findEntityValue<EntityType, Integer>(attribute.longValue()) else null;
}

"A converter between [[EntityType]]s that use [[String]]s and database tables that use [[JString]]s."
shared abstract class EnumeratedStringColumnConverter<EntityType>()
        satisfies AttributeConverter<EntityType, JString>
        given EntityType satisfies EnumeratedStringColumn {
    shared actual JString? convertToDatabaseColumn(EntityType? attribute)
            => if (exists attribute) then nativeString(attribute.databaseValue) else null;
    
    shared actual EntityType? convertToEntityAttribute(JString? attribute)
            => if (exists attribute) then findEntityValue<EntityType, String>(attribute.string) else null;
}
