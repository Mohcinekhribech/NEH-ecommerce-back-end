package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.ProductDtoRequest;
import com.openmind.neh.app.dtos.response.ProductDtoResponse;
import com.openmind.neh.app.entities.Category;
import com.openmind.neh.app.entities.Product;
import com.openmind.neh.app.entities.ProductTag;
import com.openmind.neh.app.entities.Tag;
import com.openmind.neh.app.repositories.CategoryRepository;
import com.openmind.neh.app.repositories.ProductRepository;
import com.openmind.neh.app.repositories.TagRepository;
import com.openmind.neh.app.services.interfaces.ProductServiceInterface;
import com.openmind.neh.app.services.interfaces.ProductTagServiceInterface;
import com.openmind.neh.app.specifications.ProductSpecification;
import jakarta.transaction.Transactional;
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
    private final ProductTagServiceInterface productTagService;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public ProductDtoResponse create(ProductDtoRequest productDtoRequest) {
        Optional<Category> categoryOptional = categoryRepository.findById(productDtoRequest.getCategoryId());
        return categoryOptional.map(category -> {
            Product product = modelMapper.map(productDtoRequest, Product.class);
            product.setCategory(category);
            Product product1  = productRepository.save(product);
            if (productDtoRequest.getTags() != null && !productDtoRequest.getTags().isEmpty()) {
                productTagService.createAll(product1, productDtoRequest.getTags());
            }
            return modelMapper.map(product,ProductDtoResponse.class);
        }).orElse(null);
    }

    public ProductDtoResponse addTagsToExistingProduct(UUID productId, List<UUID> tagIds) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        List<Tag> tags = tagRepository.findAllById(tagIds);

        if (tags.size() != tagIds.size()) {
            throw new RuntimeException("Some tags do not exist");
        }

        product.getProductTags().clear();

        List<ProductTag> productTags = new ArrayList<>();
        for (Tag tag : tags) {
            ProductTag productTag = new ProductTag();
            productTag.setProduct(product);
            productTag.setTag(tag);
            productTags.add(productTag);
        }

        product.setProductTags(productTags);
        productRepository.save(product);

        return modelMapper.map(product, ProductDtoResponse.class);
    }


    public ProductDtoResponse removeTagsFromExistingProduct(UUID productId, List<UUID> tagIds) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        List<ProductTag> productTagsToRemove = product.getProductTags().stream()
                .filter(pt -> tagIds.contains(pt.getTag().getId()))
                .toList();

        if (productTagsToRemove.isEmpty()) {
            throw new RuntimeException("No matching tags found to remove");
        }

        product.getProductTags().removeAll(productTagsToRemove);

        productRepository.save(product);
        return modelMapper.map(product, ProductDtoResponse.class);
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
