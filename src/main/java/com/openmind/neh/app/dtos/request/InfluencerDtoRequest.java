package com.openmind.neh.app.dtos.request;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import java.util.UUID;

@Getter
@Setter
public class InfluencerDtoRequest {
    private UUID id;
    
    @NotBlank(message = "Name is required")
    @Size(min = 2, max = 100, message = "Name must be between 2 and 100 characters")
    private String name;
    
    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;
    
    @Pattern(regexp = "^\\+?[1-9]\\d{1,14}$", message = "Invalid phone number format")
    private String phone;
    
    @NotNull(message = "Commission rate is required")
    @Min(value = 0, message = "Commission rate must be greater than or equal to 0")
    @Max(value = 100, message = "Commission rate must be less than or equal to 100")
    private Double commissionRate;
    
    private Boolean isActive = true;
} 