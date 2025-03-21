package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.ProductMediaDtoRequest;
import com.openmind.neh.app.dtos.response.ProductMediaDtoResponse;
import com.openmind.neh.shareable.CrudInterface;

import java.util.List;
import java.util.UUID;

public interface ProductMediaServiceInterface extends CrudInterface<ProductMediaDtoRequest , ProductMediaDtoResponse , UUID> {
    public List<ProductMediaDtoResponse> createAll(List<ProductMediaDtoRequest> productMediaDtoRequests) ;
}
