package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.ProductMediaDtoRequest;
import com.openmind.neh.app.dtos.response.ProductMediaDtoResponse;
import com.openmind.neh.app.services.interfaces.ProductMediaServiceInterface;
import com.openmind.neh.shareable.CrudController;
import com.openmind.neh.shareable.ResponseMessage;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/product-media")
public class ProductMediaController extends CrudController<ProductMediaDtoRequest , ProductMediaDtoResponse , UUID , ProductMediaServiceInterface> {
    public ProductMediaController(ProductMediaServiceInterface productMediaServiceInterface, ResponseMessage responseMessage) {
        super(productMediaServiceInterface, responseMessage);
    }

    @PostMapping("/all")
    public ResponseEntity<List<ProductMediaDtoResponse>> create(@Valid @RequestBody List<ProductMediaDtoRequest> dtoReq) {
        List<ProductMediaDtoResponse> dtoResp = service.createAll(dtoReq);
        if(dtoResp != null)
        {
            return ResponseEntity.ok().body(dtoResp);
        }
        return ResponseEntity.badRequest().body(null);
    }
}
