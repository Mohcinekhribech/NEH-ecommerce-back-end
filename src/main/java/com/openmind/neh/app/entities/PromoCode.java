package com.openmind.neh.app.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
public class PromoCode {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @Column(unique = true, nullable = false)
    private String code;
    
    @ManyToOne
    @JoinColumn(name = "influencer_id")
    private Influencer influencer;
    
    @Column(nullable = false)
    private Double discountPercentage;
    
    @Column(nullable = false)
    private Boolean isActive = true;
    
    @Column(nullable = false)
    private LocalDateTime validFrom;
    
    @Column(nullable = false)
    private LocalDateTime validUntil;
    
    @Column(nullable = false)
    private Integer maxUses;
    
    @Column(nullable = false)
    private Integer currentUses = 0;
    
    @OneToMany(mappedBy = "promoCode")
    private List<Order> orders;
    
    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
    
    @Column
    private LocalDateTime updatedAt;
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
} 