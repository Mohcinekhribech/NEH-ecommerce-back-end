package com.openmind.pure_essence.app.dtos.response;

import com.openmind.pure_essence.app.dtos.request.ProductDtoRequest;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class TagDtoResponse {
    private UUID id;
    private String name;
}
