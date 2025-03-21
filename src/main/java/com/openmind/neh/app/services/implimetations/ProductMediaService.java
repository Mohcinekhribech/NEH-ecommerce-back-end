package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.ProductMediaDtoRequest;
import com.openmind.neh.app.dtos.response.ProductMediaDtoResponse;
import com.openmind.neh.app.entities.Product;
import com.openmind.neh.app.entities.ProductMedia;
import com.openmind.neh.app.repositories.ProductMediaRepository;
import com.openmind.neh.app.repositories.ProductRepository;
import com.openmind.neh.app.services.interfaces.ProductMediaServiceInterface;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ProductMediaService implements ProductMediaServiceInterface {
    private final ProductMediaRepository productMediaRepository;
    private final ProductRepository productRepository;
    private final ModelMapper modelMapper;

    @Override
    public ProductMediaDtoResponse create(ProductMediaDtoRequest productMediaDtoRequest) {
        Optional<Product> productOptional = productRepository.findById(productMediaDtoRequest.getProductId());
        return productOptional.map(product -> {
            ProductMedia productMedia = modelMapper.map(productMediaDtoRequest, ProductMedia.class);
            productMedia.setProduct(product);
            return modelMapper.map(productMediaRepository.save(productMedia), ProductMediaDtoResponse.class);
        }).orElse(null);
    }

    @Override
    public List<ProductMediaDtoResponse> createAll(List<ProductMediaDtoRequest> productMediaDtoRequests) {
        Optional<Product> productOptional = productRepository.findById(productMediaDtoRequests.getFirst().getProductId());
        return productOptional.map(product -> {
            List<ProductMedia> productMedias = productMediaDtoRequests.stream().map(productMedia -> modelMapper.map(productMedia, ProductMedia.class)).toList();
            productMedias = productMedias.stream().peek(productMedia -> productMedia.setProduct(product)).toList();;
            productMedias = productMediaRepository.saveAll(productMedias);
            return productMedias.stream().map(productMedia -> modelMapper.map(productMedia, ProductMediaDtoResponse.class)).collect(Collectors.toList());
        }).orElse(null);
    }

    @Override
    public ProductMediaDtoResponse update(ProductMediaDtoRequest productMediaDtoRequest, UUID uuid) {
        Optional<ProductMedia> productMediaOptional = productMediaRepository.findById(uuid);
        return productMediaOptional.map(product -> {
            productMediaDtoRequest.setId(uuid);
            return create(productMediaDtoRequest);
        }).orElse(null);
    }

    @Override
    public Integer delete(UUID uuid) {
        ProductMedia productMedia = productMediaRepository.findById(uuid).orElse(null);
        if(productMedia != null) {
            productMediaRepository.delete(productMedia);
            return 1;
        }
        return 0;
    }

    @Override
    public List<ProductMediaDtoResponse> getAll() {
        return productMediaRepository.findAll().stream().map(productMedia -> modelMapper.map(productMedia, ProductMediaDtoResponse.class)).collect(Collectors.toList());
    }

    @Override
    public ProductMediaDtoResponse getOne(UUID uuid) {
        return modelMapper.map(productMediaRepository.findById(uuid).orElse(null),ProductMediaDtoResponse.class);
    }
}
