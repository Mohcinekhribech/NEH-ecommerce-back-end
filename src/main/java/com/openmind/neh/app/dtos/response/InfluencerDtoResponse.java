package com.openmind.neh.app.dtos.response;

import com.openmind.neh.app.dtos.request.PromoCodeDtoRequest;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class InfluencerDtoResponse {
    private UUID id;
    private String name;
    private String email;
    private String phone;
    private Double commissionRate;
    private Boolean isActive;
//    private List<PromoCodeDtoRequest> promoCodes;
//    private List<CommissionDtoRequest> commissions;
    private Double totalCommission;
    private Double unpaidCommission;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
} 