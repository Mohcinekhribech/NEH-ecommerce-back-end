package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.Commission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.UUID;

@Repository
public interface CommissionRepository extends JpaRepository<Commission, UUID> {
    List<Commission> findByInfluencerId(UUID influencerId);
    
    List<Commission> findByInfluencerIdAndIsPaidFalse(UUID influencerId);

    List<Commission> findByIsPaidTrue();

    List<Commission> findByIsPaidFalse();
    
    @Query("SELECT SUM(c.amount) FROM Commission c WHERE c.influencer.id = :influencerId AND c.isPaid = false")
    Double getTotalUnpaidCommission(UUID influencerId);
    
    @Query("SELECT SUM(c.amount) FROM Commission c WHERE c.influencer.id = :influencerId")
    Double getTotalCommission(UUID influencerId);
    
    List<Commission> findByOrderId(UUID orderId);
    List<Commission> findByInfluencer_IdAndIsPaidFalse(UUID influencerId);

} 