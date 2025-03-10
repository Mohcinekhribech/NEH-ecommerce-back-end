package com.openmind.pure_essence.app.services.interfaces;

import com.openmind.pure_essence.app.dtos.request.ProductDtoRequest;
import com.openmind.pure_essence.app.dtos.response.ProductDtoResponse;
import com.openmind.pure_essence.app.entities.Product;
import com.openmind.pure_essence.shareable.CrudInterface;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.UUID;

public interface ProductServiceInterface extends CrudInterface<ProductDtoRequest, ProductDtoResponse, UUID> {
    ProductDtoResponse addTagsToExistingProduct(UUID productId, List<UUID> tagIds);
    ProductDtoResponse removeTagsFromExistingProduct(UUID productId, List<UUID> tagIds);
    Page<ProductDtoResponse> searchProducts(String name, String categoryId, Double minPrice, Double maxPrice, Double minWeight, Double maxWeight, Boolean inStock, UUID tagId, Pageable pageable);
    List<ProductDtoResponse> getBestProducts();
}
