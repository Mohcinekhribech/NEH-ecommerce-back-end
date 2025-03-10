package com.openmind.pure_essence.app.specifications;

import com.openmind.pure_essence.app.entities.Product;
import jakarta.persistence.criteria.*;
import org.springframework.data.jpa.domain.Specification;
import java.util.UUID;

public class ProductSpecification {

    public static Specification<Product> hasName(String name) {
        return (root, query, criteriaBuilder) ->
                name != null ? criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + name.toLowerCase() + "%") : null;
    }

    public static Specification<Product> hasCategory(String categoryName) {
        return (root, query, criteriaBuilder) ->
                categoryName != null ? criteriaBuilder.like(criteriaBuilder.lower(root.get("category").get("name")), "%" + categoryName.toLowerCase() + "%") : null;
    }

    public static Specification<Product> hasMinPrice(Double minPrice) {
        return (root, query, criteriaBuilder) ->
                minPrice != null ? criteriaBuilder.greaterThanOrEqualTo(root.get("finalPrice"), minPrice) : null;
    }

    public static Specification<Product> hasMaxPrice(Double maxPrice) {
        return (root, query, criteriaBuilder) ->
                maxPrice != null ? criteriaBuilder.lessThanOrEqualTo(root.get("finalPrice"), maxPrice) : null;
    }

    public static Specification<Product> hasMinWeight(Double minWeight) {
        return (root, query, criteriaBuilder) ->
                minWeight != null ? criteriaBuilder.greaterThanOrEqualTo(root.get("weight"), minWeight) : null;
    }

    public static Specification<Product> hasMaxWeight(Double maxWeight) {
        return (root, query, criteriaBuilder) ->
                maxWeight != null ? criteriaBuilder.lessThanOrEqualTo(root.get("weight"), maxWeight) : null;
    }

    public static Specification<Product> isInStock(Boolean inStock) {
        return (root, query, criteriaBuilder) ->
                inStock != null ? criteriaBuilder.equal(criteriaBuilder.greaterThan(root.get("quantity"), 0), inStock) : null;
    }

    public static Specification<Product> hasTag(UUID tagId) {
        return (root, query, criteriaBuilder) -> {
            if (tagId != null) {
                Join<Object, Object> tagsJoin = root.join("tags", JoinType.INNER);
                return criteriaBuilder.equal(tagsJoin.get("id"), tagId);
            }
            return null;
        };
    }
}

