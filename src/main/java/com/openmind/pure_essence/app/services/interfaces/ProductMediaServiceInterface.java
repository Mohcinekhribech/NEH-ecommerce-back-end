package com.openmind.pure_essence.app.services.interfaces;

import com.openmind.pure_essence.app.dtos.request.ProductMediaDtoRequest;
import com.openmind.pure_essence.app.dtos.response.ProductMediaDtoResponse;
import com.openmind.pure_essence.shareable.CrudInterface;

import java.util.List;
import java.util.UUID;

public interface ProductMediaServiceInterface extends CrudInterface<ProductMediaDtoRequest , ProductMediaDtoResponse , UUID> {
    public List<ProductMediaDtoResponse> createAll(List<ProductMediaDtoRequest> productMediaDtoRequests) ;
}
