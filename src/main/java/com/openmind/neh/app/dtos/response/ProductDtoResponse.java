package com.openmind.neh.app.dtos.response;

import com.openmind.neh.app.dtos.request.CategoryDtoRequest;
import com.openmind.neh.app.dtos.request.ProductMediaDtoRequest;
import com.openmind.neh.app.dtos.request.TagDtoRequest;
import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class ProductDtoResponse {
    private UUID id;
    private CategoryDtoRequest category;
    private String name;
    private String description;
    private String benefits;
    private String howToUse;
    private Double purchasePrice;
    private Double finalPrice;
    private Integer quantity;
    private Double weight;
    private List<TagDtoRequest> tags;
    private List<ProductMediaDtoRequest> productMedias;
}