package com.openmind.pure_essence.app.repositories;

import com.openmind.pure_essence.app.entities.OrderedProduct;
import com.openmind.pure_essence.app.entities.embededId.OrderedProductId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderedProductRepository extends JpaRepository<OrderedProduct, OrderedProductId> {
}
