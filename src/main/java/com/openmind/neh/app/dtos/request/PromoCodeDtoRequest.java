package com.openmind.neh.app.dtos.request;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class PromoCodeDtoRequest {
    private UUID id;
    
    @NotBlank(message = "Code is required")
    @Size(min = 3, max = 20, message = "Code must be between 3 and 20 characters")
    private String code;
    
    @NotNull(message = "Influencer ID is required")
    private UUID influencerId;
    
    @NotNull(message = "Discount percentage is required")
    @Min(value = 0, message = "Discount percentage must be greater than or equal to 0")
    @Max(value = 100, message = "Discount percentage must be less than or equal to 100")
    private Double discountPercentage;
    
    @NotNull(message = "Valid from date is required")
    private LocalDateTime validFrom;
    
    @NotNull(message = "Valid until date is required")
    private LocalDateTime validUntil;
    
    @NotNull(message = "Maximum uses is required")
    @Min(value = 1, message = "Maximum uses must be at least 1")
    private Integer maxUses;
    
    private Boolean isActive = true;
} 