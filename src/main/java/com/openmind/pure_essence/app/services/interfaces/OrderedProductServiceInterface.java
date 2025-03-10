package com.openmind.pure_essence.app.services.interfaces;

import com.openmind.pure_essence.app.dtos.request.OrderedProductDtoRequest;
import com.openmind.pure_essence.app.dtos.response.OrderedProductDtoResponse;
import com.openmind.pure_essence.app.entities.embededId.OrderedProductId;
import com.openmind.pure_essence.shareable.CrudInterface;

public interface OrderedProductServiceInterface extends CrudInterface<OrderedProductDtoRequest, OrderedProductDtoResponse , OrderedProductId> {
}
