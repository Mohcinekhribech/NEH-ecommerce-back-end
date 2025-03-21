package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.OrderedProduct;
import com.openmind.neh.app.entities.embededId.OrderedProductId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderedProductRepository extends JpaRepository<OrderedProduct, OrderedProductId> {
}
