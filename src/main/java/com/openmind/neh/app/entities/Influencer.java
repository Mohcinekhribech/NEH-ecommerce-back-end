package com.openmind.neh.app.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.util.UUID;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Influencer {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    @Column
    private String phone;
    
    @Column(nullable = false)
    private Double commissionRate;
    
    @OneToMany(mappedBy = "influencer", cascade = CascadeType.ALL)
    private List<PromoCode> promoCodes;
    
    @OneToMany(mappedBy = "influencer", cascade = CascadeType.ALL)
    private List<Commission> commissions;
    
    @Column(nullable = false)
    private Boolean isActive = true;
    
    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
    
    @Column
    private LocalDateTime updatedAt;
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
} 