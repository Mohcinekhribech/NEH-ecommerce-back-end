package com.openmind.neh.app.dtos.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class TagDtoRequest {
    private UUID id;
    @NotBlank(message = "Tag name is required")
    @Size(max = 255, message = "Tag name must be at most 255 characters")
    private String name;
}
