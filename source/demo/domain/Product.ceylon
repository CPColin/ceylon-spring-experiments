import ceylon.time {
    Date,
    Time,
    YearMonth,
    time,
    today,
    yearMonth
}
import ceylon.time.base {
    march
}

import java.math {
    BigDecimal
}

import javax.persistence {
    entity
}

entity
shared class Product(
    shared String productId = "",
    shared ProductType productType = ProductType.unknown,
    shared String description = "",
    shared String imageUrl = "",
    shared BigDecimal price = BigDecimal.zero,
    shared Date expirationDate = today(),
    shared Time expirationTime = time(12, 34, 56),
    shared YearMonth expirationMonth = yearMonth(2010, march))
        extends Entity() {}
