package com.openmind.neh.app.dtos.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderedProductDtoResponse {
    private ProductDtoResponse product;
    private Integer quantity;
    private Double unitPrice;
    private Double totalPrice;
}
