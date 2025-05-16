package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.PromoCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PromoCodeRepository extends JpaRepository<PromoCode, UUID> {
    Optional<PromoCode> findByCode(String code);
    
    List<PromoCode> findByInfluencerId(UUID influencerId);
    
    @Query("SELECT p FROM PromoCode p WHERE p.isActive = true AND p.validFrom <= :now AND p.validUntil >= :now AND p.currentUses < p.maxUses")
    List<PromoCode> findActivePromoCodes(LocalDateTime now);
    
    @Query("SELECT p FROM PromoCode p WHERE p.influencer.id = :influencerId AND p.isActive = true AND p.validFrom <= :now AND p.validUntil >= :now AND p.currentUses < p.maxUses")
    List<PromoCode> findActivePromoCodesByInfluencer(UUID influencerId, LocalDateTime now);
    
    boolean existsByCode(String code);
} 