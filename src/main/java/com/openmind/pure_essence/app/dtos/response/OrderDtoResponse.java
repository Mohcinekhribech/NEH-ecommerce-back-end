package com.openmind.pure_essence.app.dtos.response;

import com.openmind.pure_essence.app.dtos.request.ClientDtoRequest;
import com.openmind.pure_essence.app.dtos.request.OrderedProductDtoRequest;
import com.openmind.pure_essence.app.entities.enums.OrderStatus;
import com.openmind.pure_essence.app.entities.enums.PaymentMethod;
import com.openmind.pure_essence.app.entities.enums.PaymentStatus;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class OrderDtoResponse {
    private UUID id;
    private LocalDateTime dateOfCreation ;
    private ClientDtoRequest client;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String address;
    private String city;
    private String zipCode;
    private String country;
    private Boolean delivered;
    private Double totalPrice;
    private OrderStatus status;       // Current status of the order
    private PaymentStatus paymentStatus; // Current payment status of the order
    private PaymentMethod paymentMethod;
    private List<OrderedProductDtoResponse> orderedProducts;
}
