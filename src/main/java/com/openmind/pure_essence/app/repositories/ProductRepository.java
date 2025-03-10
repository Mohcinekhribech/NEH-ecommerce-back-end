package com.openmind.pure_essence.app.repositories;

import com.openmind.pure_essence.app.entities.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;
@Repository
public interface ProductRepository extends JpaRepository<Product, UUID> , JpaSpecificationExecutor<Product> {
    @Query("SELECT p FROM Product p ORDER BY SIZE(p.orderedProducts) DESC LIMIT 6")
    List<Product> findBestProducts();
    Page<Product> findAll(Pageable pageable);
}