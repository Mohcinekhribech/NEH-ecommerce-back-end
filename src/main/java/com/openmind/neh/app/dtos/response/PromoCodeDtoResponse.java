package com.openmind.neh.app.dtos.response;

import com.openmind.neh.app.dtos.request.InfluencerDtoRequest;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class PromoCodeDtoResponse {
    private UUID id;
    private String code;
    private InfluencerDtoRequest influencer;
    private Double discountPercentage;
    private Boolean isActive;
    private LocalDateTime validFrom;
    private LocalDateTime validUntil;
    private Integer maxUses;
    private Integer currentUses;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
} 