package com.openmind.pure_essence.app.dtos.request;


import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class OrderedProductDtoRequest {

    @NotNull(message = "Order ID is required")
    private UUID orderId;

    @NotNull(message = "Product ID is required")
    private UUID productId;

    @NotNull(message = "Quantity is required")
    @Min(value = 1, message = "Quantity must be at least 1")
    private Integer quantity;

    @NotNull(message = "Unit price is required")
    @Positive(message = "Unit price must be greater than zero")
    private Double unitPrice;

    @NotNull(message = "Total price is required")
    @Positive(message = "Total price must be greater than zero")
    private Double totalPrice;
}
