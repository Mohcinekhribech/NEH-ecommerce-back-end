package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.ProductDtoRequest;
import com.openmind.neh.app.dtos.response.ProductDtoResponse;
import com.openmind.neh.app.services.interfaces.ProductServiceInterface;
import com.openmind.neh.shareable.CrudController;
import com.openmind.neh.shareable.ResponseMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;
@RestController
@RequestMapping("/api/product")
public class ProductController extends CrudController<ProductDtoRequest, ProductDtoResponse , UUID , ProductServiceInterface > {
    public ProductController(ProductServiceInterface productServiceInterface, ResponseMessage responseMessage) {
        super(productServiceInterface, responseMessage);
    }

    @PutMapping("/{productId}/tags")
    public ResponseEntity<ProductDtoResponse> addTagsToProduct(@PathVariable UUID productId, @RequestBody List<UUID> tagIds) {
        ProductDtoResponse dtoResp = service.addTagsToExistingProduct(productId,tagIds);
        if(dtoResp != null)
        {
            return ResponseEntity.ok().body(dtoResp);
        }
        return ResponseEntity.badRequest().body(null);
    }

    // 3. Endpoint to remove tags from an existing product
    @PutMapping("/{productId}/tags/remove")
    public ResponseEntity<ProductDtoResponse> removeTagsFromProduct(@PathVariable UUID productId, @RequestBody List<UUID> tagIds) {
        ProductDtoResponse dtoResp = service.removeTagsFromExistingProduct(productId,tagIds);
        if(dtoResp != null)
        {
            return ResponseEntity.ok().body(dtoResp);
        }
        return ResponseEntity.badRequest().body(null);
    }

    @GetMapping("/search")
    public ResponseEntity<Page<ProductDtoResponse>> searchProducts(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String categoryName,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) Double minWeight,
            @RequestParam(required = false) Double maxWeight,
            @RequestParam(required = false) Boolean inStock,
            @RequestParam(required = false) UUID tagId,
            Pageable pageable
    ) {
        return ResponseEntity.ok().body(service.searchProducts(name, categoryName, minPrice, maxPrice, minWeight, maxWeight, inStock, tagId,pageable));
    }

    @GetMapping("/best")
    public ResponseEntity<List<ProductDtoResponse>> getBestProducts() {
        List<ProductDtoResponse> bestProducts = service.getBestProducts();
        return ResponseEntity.ok(bestProducts);
    }

}
