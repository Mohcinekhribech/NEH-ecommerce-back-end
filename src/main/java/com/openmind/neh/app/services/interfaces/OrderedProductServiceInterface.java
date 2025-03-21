package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.OrderedProductDtoRequest;
import com.openmind.neh.app.dtos.response.OrderedProductDtoResponse;
import com.openmind.neh.app.entities.embededId.OrderedProductId;
import com.openmind.neh.shareable.CrudInterface;

public interface OrderedProductServiceInterface extends CrudInterface<OrderedProductDtoRequest, OrderedProductDtoResponse , OrderedProductId> {
}
