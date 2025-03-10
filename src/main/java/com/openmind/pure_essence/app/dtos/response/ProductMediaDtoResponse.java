package com.openmind.pure_essence.app.dtos.response;

import com.openmind.pure_essence.app.dtos.request.ProductDtoRequest;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.UUID;

@Getter
@Setter
public class ProductMediaDtoResponse {
    private UUID id;
    private String mediaName;
}
