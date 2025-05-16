package com.openmind.neh.app.dtos.request;


import com.openmind.neh.app.entities.enums.OrderStatus;
import com.openmind.neh.app.entities.enums.PaymentMethod;
import com.openmind.neh.app.entities.enums.PaymentStatus;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class OrderDtoRequest {
    private UUID id;

    private LocalDateTime dateOfCreation = LocalDateTime.now();

    @NotBlank(message = "First name is required")
    @Size(min = 2, max = 50, message = "First name must be between 2 and 50 characters")
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(min = 2, max = 50, message = "Last name must be between 2 and 50 characters")
    private String lastName;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    @NotBlank(message = "Phone number is required")
    @Pattern(regexp = "^(\\+?\\d{10,15})$", message = "Invalid phone number format")
    private String phone;

    @NotBlank(message = "Address is required")
    @Size(max = 255, message = "Address must not exceed 255 characters")
    private String address;

    @NotNull(message = "Order status is required")
    private OrderStatus status = OrderStatus.PENDING;

    @NotNull(message = "Payment status is required")
    private PaymentStatus paymentStatus;

    @NotNull(message = "Payment method is required")
    private PaymentMethod paymentMethod;

    @NotBlank(message = "City is required")
    @Size(min = 2, max = 100, message = "City name must be between 2 and 100 characters")
    private String city;

    @NotBlank(message = "Zip code is required")
    @Size(min = 3, max = 20, message = "Zip code must be between 3 and 20 characters")
    private String zipCode;

    @NotNull(message = "Client ID is required")
    private UUID clientId;

    @NotBlank(message = "Country is required")
    @Size(min = 2, max = 100, message = "Country name must be between 2 and 100 characters")
    private String country;


    @NotNull(message = "Total price is required")
    @Positive(message = "Total price must be greater than zero")
    private Double totalPrice;

    @NotEmpty(message = "At least one ordered product is required")
    private List<OrderedProductDtoRequest> orderedProducts;

    private String promoCode;
}
