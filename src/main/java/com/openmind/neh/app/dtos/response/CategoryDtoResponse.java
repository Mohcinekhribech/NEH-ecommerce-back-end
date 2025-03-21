package com.openmind.neh.app.dtos.response;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class CategoryDtoResponse {
    private UUID id;
    private String name;
    private String image;
    private String description;
}
