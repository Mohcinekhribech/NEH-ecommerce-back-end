package com.openmind.pure_essence.app.entities.enums;

public enum PaymentStatus {
    PENDING,               // Payment pending
    PAID,                  // Payment completed successfully
    PAYMENT_FAILED,        // Payment failed
    REFUND_INITIATED,      // Refund process started
    REFUNDED,              // Payment refunded
    COD_PENDING,           // COD payment pending
    COD_COLLECTED,         // COD payment collected
    COD_FAILED             // COD payment failed
}