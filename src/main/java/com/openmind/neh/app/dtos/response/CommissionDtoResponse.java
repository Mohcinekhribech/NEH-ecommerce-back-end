package com.openmind.neh.app.dtos.response;

import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class CommissionDtoResponse {
    private UUID id;
    private InfluencerDtoResponse influencer;
    private OrderDtoResponse order;
    private Double amount;
    private Boolean isPaid;
    private LocalDateTime paidAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
} 