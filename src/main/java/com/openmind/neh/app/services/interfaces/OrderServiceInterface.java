package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.OrderDtoRequest;
import com.openmind.neh.app.dtos.response.OrderDtoResponse;
import com.openmind.neh.app.entities.enums.OrderStatus;
import com.openmind.neh.app.entities.enums.PaymentStatus;
import com.openmind.neh.shareable.CrudInterface;
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