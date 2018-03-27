package demo.util;

import ceylon.language.Integer;
import ceylon.language.String;
import com.redhat.ceylon.common.NonNull;
import com.redhat.ceylon.compiler.java.metadata.Ignore;
import com.redhat.ceylon.compiler.java.metadata.TypeParameter;
import com.redhat.ceylon.compiler.java.metadata.TypeParameters;
import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * JPA-based implementation of {@link CeylonRepository}.
 *
 * Performs type conversion on identifiers of type
 * {@link ceylon.language.Integer} and
 * {@link ceylon.language.String}.
 *
 * @param <Entity> the entity type
 * @param <Id> the identifier type
 */
@Transactional(readOnly = true)
@TypeParameters({@TypeParameter(value = "Entity",
                                satisfies = "ceylon.language::Object"),
                 @TypeParameter(value = "Id",
                                satisfies = "ceylon.language::Object")})
public class CeylonRepositoryImpl<Entity, Id extends Serializable>
        extends SimpleJpaRepository<Entity, Id>
        implements CeylonRepository<Entity, Id> {

    public CeylonRepositoryImpl(JpaEntityInformation<Entity, ?> entityInformation,
                                EntityManager entityManager) {
        super(entityInformation, entityManager);
    }

    @Override @Ignore @Transactional
    public void deleteById(@NonNull Id id) {
        super.deleteById(toJavaId(id));
    }

    @Override @Ignore
    public boolean existsById(@NonNull Id id) {
        return super.existsById(toJavaId(id));
    }

    @Override @Ignore @NonNull
    public Entity getOne(@NonNull Id id) {
        return super.getOne(toJavaId(id));
    }

    @Override @Ignore @NonNull
    public Optional<Entity> findById(@NonNull Id id) {
        return super.findById(toJavaId(id));
    }

    @Override @Ignore @NonNull
    public List<Entity> findAllById(@NonNull Iterable<Id> ids) {
        List<Id> javaIds = new ArrayList<Id>();
        for (Id id: ids) {
            javaIds.add(toJavaId(id));
        }
        return super.findAllById(javaIds);
    }

    @SuppressWarnings("unchecked")
    @NonNull private Id toJavaId(@NonNull Id id) {
        Object javaId;
        if (id instanceof Integer) {
            javaId = ((Integer) id).longValue();
        }
        else if (id instanceof String) {
            javaId = id.toString();
        }
        else {
            javaId = id;
        }
        return (Id) javaId;
    }
}
