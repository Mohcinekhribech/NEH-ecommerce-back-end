package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.ProductTag;
import com.openmind.neh.app.entities.embededId.ProductTagId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductTagRepository extends JpaRepository<ProductTag, ProductTagId> {
}
