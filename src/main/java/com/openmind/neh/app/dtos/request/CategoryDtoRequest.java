package com.openmind.neh.app.dtos.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class CategoryDtoRequest {
    private UUID id;
    @NotBlank(message = "Category name is required")
    @Size(min = 2, max = 100, message = "Category name must be between 2 and 100 characters")
    private String name;

    @NotBlank(message = "Image URL is required")
    private String image;

    @Size(max = 255, message = "Description must not exceed 255 characters")
    private String description;
}
