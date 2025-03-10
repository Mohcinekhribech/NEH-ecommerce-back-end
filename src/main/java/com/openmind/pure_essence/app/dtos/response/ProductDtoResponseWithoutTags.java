package com.openmind.pure_essence.app.dtos.response;

import com.openmind.pure_essence.app.dtos.request.CategoryDtoRequest;
import com.openmind.pure_essence.app.dtos.request.ProductMediaDtoRequest;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class ProductDtoResponseWithoutTags {
    private UUID id;
    private CategoryDtoRequest category;
    private String name;
    private String description;
    private Double purchasePrice;
    private Double finalPrice;
    private Integer quantity;
    private Double weight;
    private List<ProductMediaDtoRequest> productMedias;
}
