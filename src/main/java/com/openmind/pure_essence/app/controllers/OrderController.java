package com.openmind.pure_essence.app.controllers;

import com.openmind.pure_essence.app.dtos.request.OrderDtoRequest;
import com.openmind.pure_essence.app.dtos.response.OrderDtoResponse;
import com.openmind.pure_essence.app.entities.enums.OrderStatus;
import com.openmind.pure_essence.app.entities.enums.PaymentStatus;
import com.openmind.pure_essence.app.services.interfaces.OrderServiceInterface;
import com.openmind.pure_essence.shareable.CrudController;
import com.openmind.pure_essence.shareable.ResponseMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("api/orders")
public class OrderController extends CrudController<OrderDtoRequest , OrderDtoResponse , UUID , OrderServiceInterface> {
    public OrderController(OrderServiceInterface orderServiceInterface, ResponseMessage responseMessage) {
        super(orderServiceInterface, responseMessage);
    }

    @PutMapping("/payment-status/{PaymentStatus}/{orderId}")
    public ResponseEntity<Boolean> updatePaymentStatus(@PathVariable("orderId") UUID orderId, @PathVariable("PaymentStatus") PaymentStatus paymentStatus){
        Boolean isUpdated = service.updatePaymentStatus(paymentStatus,orderId);
        if(isUpdated)
        {
            return ResponseEntity.ok().body(true);
        }
        return ResponseEntity.badRequest().body(false);
    }

    @PutMapping("/status/{orderStatus}/{orderId}")
    public ResponseEntity<Boolean> updateOrderStatus(@PathVariable("orderId") UUID orderId, @PathVariable("orderStatus") OrderStatus orderStatus){
        Boolean isUpdated = service.updateOrderStatus(orderStatus,orderId);
        if(isUpdated)
        {
            return ResponseEntity.ok().body(true);
        }
        return ResponseEntity.badRequest().body(false);
    }

    @GetMapping("/recent")
    public ResponseEntity<List<OrderDtoResponse>> getRecentOrders() {
        List<OrderDtoResponse> recentOrders = service.getRecentOrders();
        return ResponseEntity.ok(recentOrders);
    }

    @GetMapping("client/{id}")
    public ResponseEntity<List<OrderDtoResponse>> getOrdersByClientId(@PathVariable("id") UUID id) {
        List<OrderDtoResponse> recentOrders = service.getOrdersByClientId(id);
        return ResponseEntity.ok(recentOrders);
    }

    @GetMapping("pageable")
    public ResponseEntity<Page<OrderDtoResponse>> getOrders(Pageable pageable) {
        Page<OrderDtoResponse> recentOrders = service.getAllPageable(pageable);
        return ResponseEntity.ok(recentOrders);
    }
}