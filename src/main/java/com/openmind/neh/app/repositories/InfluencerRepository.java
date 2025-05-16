package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.Influencer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface InfluencerRepository extends JpaRepository<Influencer, UUID> {
    Optional<Influencer> findByEmail(String email);
    
    List<Influencer> findByIsActiveTrue();
    
    @Query("SELECT i FROM Influencer i WHERE i.isActive = true AND SIZE(i.commissions) > 0")
    List<Influencer> findActiveInfluencersWithCommissions();
    
    boolean existsByEmail(String email);
} 