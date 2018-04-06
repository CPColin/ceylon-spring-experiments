import interop.spring {
    EnumeratedStringColumn,
    EnumeratedStringColumnConverter,
    cv=cvalues,
    jv=jvalues
}

import java.lang {
    JIterable=Iterable
}

import javax.persistence {
    converter
}

import org.springframework.stereotype {
    component
}

//"A [[Product]] type column that uses integers as the ID."
//shared class ProductType
//        of unknown | mug | shirt
//        extends EnumeratedIntegerColumn {
//    component
//    converter { autoApply = true; }
//    shared static class Converter() extends EnumeratedIntegerColumnConverter<ProductType>() {}
//    
//    shared static {ProductType*} cvalues => cv(`ProductType`);
//    
//    shared static JIterable<ProductType> jvalues => jv(`ProductType`);
//    
//    shared new unknown extends EnumeratedIntegerColumn(0) {}
//    
//    shared new mug extends EnumeratedIntegerColumn(10) {}
//    
//    shared new shirt extends EnumeratedIntegerColumn(20) {}
//}

"A [[Product]] type column that uses strings as the ID."
shared class ProductType
        of unknown | mug | shirt
        extends EnumeratedStringColumn {
    component
    converter { autoApply = true; }
    shared static class Converter() extends EnumeratedStringColumnConverter<ProductType>() {}
    
    shared static {ProductType*} cvalues => cv(`ProductType`);
    
    shared static JIterable<ProductType> jvalues => jv(`ProductType`);
    
    shared new unknown extends EnumeratedStringColumn("Unknown") {}
    
    shared new mug extends EnumeratedStringColumn("Mug") {}
    
    shared new shirt extends EnumeratedStringColumn("Shirt") {}
}
