package com.openmind.neh.app.dtos.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class CommissionDtoRequest {
    private UUID id;

    @NotNull(message = "Influencer ID is required")
    private UUID influencerId;

    @NotNull(message = "Order ID is required")
    private UUID orderId;

    @NotNull(message = "Amount is required")
    private Double amount;

    private Boolean isPaid = false;
}
