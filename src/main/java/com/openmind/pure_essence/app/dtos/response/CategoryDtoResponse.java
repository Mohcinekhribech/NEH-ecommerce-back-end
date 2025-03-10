package com.openmind.pure_essence.app.dtos.response;

import com.openmind.pure_essence.app.dtos.request.ProductDtoRequest;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class CategoryDtoResponse {
    private UUID id;
    private String name;
    private String image;
    private String description;
}
