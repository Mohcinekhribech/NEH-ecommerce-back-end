package com.openmind.pure_essence.app.services.implimetations;

import com.openmind.pure_essence.app.dtos.request.ProductDtoRequest;
import com.openmind.pure_essence.app.dtos.request.ProductMediaDtoRequest;
import com.openmind.pure_essence.app.dtos.response.CategoryDtoResponse;
import com.openmind.pure_essence.app.dtos.response.ProductDtoResponse;
import com.openmind.pure_essence.app.entities.Category;
import com.openmind.pure_essence.app.entities.Product;
import com.openmind.pure_essence.app.entities.Tag;
import com.openmind.pure_essence.app.repositories.CategoryRepository;
import com.openmind.pure_essence.app.repositories.ProductRepository;
import com.openmind.pure_essence.app.repositories.TagRepository;
import com.openmind.pure_essence.app.services.interfaces.ProductMediaServiceInterface;
import com.openmind.pure_essence.app.services.interfaces.ProductServiceInterface;
import com.openmind.pure_essence.app.specifications.ProductSpecification;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ProductService implements ProductServiceInterface {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final TagRepository tagRepository;
    private final ModelMapper modelMapper;

    @Override
    public ProductDtoResponse create(ProductDtoRequest productDtoRequest) {
        Optional<Category> categoryOptional = categoryRepository.findById(productDtoRequest.getCategoryId());
        return categoryOptional.map(category -> {
            Product product = modelMapper.map(productDtoRequest, Product.class);
            if(productDtoRequest.getTags() != null)
            {
                List<Tag> tags = tagRepository.findAllById(productDtoRequest.getTags());
                product.setCategory(category);
                for (Tag tag : tags) {
                    tag.getProducts().add(product); // Update the tag's list of products
                }

                product.setTags(tags); // Update the product's list of tags
            }else {
                product.setTags(null);
            }

            product.setCategory(category);
            return modelMapper.map(productRepository.save(product),ProductDtoResponse.class);
        }).orElse(null);
    }

    public ProductDtoResponse addTagsToExistingProduct(UUID productId, List<UUID> tagIds) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        List<Tag> tags = tagRepository.findAllById(tagIds);
        product.setTags(tags);
        return modelMapper.map(productRepository.save(product),ProductDtoResponse.class);
    }

    public ProductDtoResponse removeTagsFromExistingProduct(UUID productId, List<UUID> tagIds) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        Set<Tag> tagsToRemove = new HashSet<>(tagRepository.findAllById(tagIds));
        product.getTags().removeAll(tagsToRemove);

        return modelMapper.map(productRepository.save(product),ProductDtoResponse.class);
    }

    @Override
    public ProductDtoResponse update(ProductDtoRequest productDtoRequest, UUID uuid) {
        Optional<Product> productOptional = productRepository.findById(uuid);
        return productOptional.map(product -> {
            productDtoRequest.setId(uuid);
            return create(productDtoRequest);
        }).orElse(null);
    }

    @Override
    public Integer delete(UUID uuid) {
        Product product = productRepository.findById(uuid).orElse(null);
        if(product != null) {
            productRepository.delete(product);
            return 1;
        }
        return 0;
    }

    @Override
    public List<ProductDtoResponse> getAll() {
        return productRepository.findAll().stream().map(product -> modelMapper.map(product, ProductDtoResponse.class)).collect(Collectors.toList());
    }

    @Override
    public ProductDtoResponse getOne(UUID uuid) {
        return modelMapper.map(productRepository.findById(uuid).orElse(null),ProductDtoResponse.class);
    }

    @Override
    public Page<ProductDtoResponse> searchProducts(String name, String categoryId, Double minPrice, Double maxPrice, Double minWeight, Double maxWeight, Boolean inStock, UUID tagId, Pageable pageable) {
        Specification<Product> spec = Specification.where(ProductSpecification.hasName(name))
                .and(ProductSpecification.hasCategory(categoryId))
                .and(ProductSpecification.hasMinPrice(minPrice))
                .and(ProductSpecification.hasMaxPrice(maxPrice))
                .and(ProductSpecification.hasMinWeight(minWeight))
                .and(ProductSpecification.hasMaxWeight(maxWeight))
                .and(ProductSpecification.isInStock(inStock))
                .and(ProductSpecification.hasTag(tagId));

        return productRepository.findAll(spec,pageable).map(product -> modelMapper.map(product, ProductDtoResponse.class));
    }

    @Override
    public List<ProductDtoResponse> getBestProducts() {
        return productRepository.findBestProducts().stream().map(product -> modelMapper.map(product, ProductDtoResponse.class)).collect(Collectors.toList());
    }
}
