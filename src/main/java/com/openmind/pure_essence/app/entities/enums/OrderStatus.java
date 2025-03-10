package com.openmind.pure_essence.app.entities.enums;

public enum OrderStatus {
    PENDING,               // Order placed but not yet processed
    CONFIRMED,             // Order confirmed by the seller
    PROCESSING,            // Order is being prepared
    SHIPPED,               // Order has been shipped
    OUT_FOR_DELIVERY,      // Order is out for delivery
    DELIVERED,             // Order delivered to the client
    CANCELLED,             // Order was cancelled (could be by client or seller, depending on context)
    RETURNED,              // Order returned by the client
    REFUNDED,              // Payment refunded to the client
    PAYMENT_FAILED,        // Payment process failed
    REFUSED_BY_CLIENT,     // Order refused by the client
    REFUSED_BY_SELLER      // Order refused by the seller
}
