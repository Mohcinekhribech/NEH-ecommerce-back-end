package com.openmind.neh.app.dtos.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class ProductMediaDtoRequest {

    private UUID id;

    @NotBlank(message = "Media name is required")
    private String mediaName;

    @NotNull(message = "Product ID is required")
    private UUID productId;
}
