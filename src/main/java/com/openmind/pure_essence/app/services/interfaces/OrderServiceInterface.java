package com.openmind.pure_essence.app.services.interfaces;

import com.openmind.pure_essence.app.dtos.request.OrderDtoRequest;
import com.openmind.pure_essence.app.dtos.response.OrderDtoResponse;
import com.openmind.pure_essence.app.entities.enums.OrderStatus;
import com.openmind.pure_essence.app.entities.enums.PaymentStatus;
import com.openmind.pure_essence.shareable.CrudInterface;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.UUID;

public interface OrderServiceInterface extends CrudInterface<OrderDtoRequest, OrderDtoResponse , UUID> {
    Boolean updatePaymentStatus(PaymentStatus paymentStatus, UUID orderId);
    List<OrderDtoResponse> getRecentOrders();
    List<OrderDtoResponse> getOrdersByClientId(UUID clientId);
    Boolean updateOrderStatus(OrderStatus orderStatus, UUID orderId) ;
    Page<OrderDtoResponse> getAllPageable(Pageable pageable) ;
}