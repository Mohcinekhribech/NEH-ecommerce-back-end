package com.openmind.neh.app.controllers;

import com.openmind.neh.app.services.interfaces.PaypalServiceInterface;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/api/paypal")
public class PaypalController {

    private final PaypalServiceInterface paypalService;

    @PostMapping("/verify-payment/{orderId}")
    public ResponseEntity<?> verifyPayment(@PathVariable String orderId) {

        try {
            String status = paypalService.verifyPayment(orderId);
            if ("COMPLETED".equals(status)) {
                return ResponseEntity.ok(true);
            } else {
                return ResponseEntity.badRequest().body(false);
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error verifying payment: " + e.getMessage());
        }
    }
}
