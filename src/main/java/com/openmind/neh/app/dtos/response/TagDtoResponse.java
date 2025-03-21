package com.openmind.neh.app.dtos.response;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class TagDtoResponse {
    private UUID id;
    private String name;
}
