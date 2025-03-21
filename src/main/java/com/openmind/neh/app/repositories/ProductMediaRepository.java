package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.ProductMedia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ProductMediaRepository extends JpaRepository<ProductMedia, UUID> {
}
