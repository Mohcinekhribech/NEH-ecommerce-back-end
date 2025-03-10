package com.openmind.pure_essence.app.dtos.request;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.util.UUID;


@Getter
@Setter
public class ProductDtoRequest {

    private UUID id; // Optional, usually generated automatically

    @NotNull(message = "Category ID is required")
    private UUID categoryId;

    @NotBlank(message = "Product name is required")
    @Size(max = 255, message = "Product name must be at most 255 characters")
    private String name;

    @NotBlank(message = "Description is required")
    private String description;

    private String benefits; // Optional field

    private String howToUse; // Optional field

    @NotNull(message = "Purchase price is required")
    @Positive(message = "Purchase price must be greater than zero")
    private Double purchasePrice;

    @NotNull(message = "Final price is required")
    @Positive(message = "Final price must be greater than zero")
    private Double finalPrice;

    @NotNull(message = "Quantity is required")
    @Min(value = 0, message = "Quantity cannot be negative")
    private Integer quantity;

    @NotNull(message = "Weight is required")
    @Positive(message = "Weight must be greater than zero")
    private Double weight;

    private List<UUID> tags;
}