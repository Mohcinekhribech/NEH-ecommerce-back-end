package com.openmind.neh.app.entities;

import com.openmind.neh.app.entities.embededId.OrderedProductId;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class OrderedProduct {
    @EmbeddedId
    private OrderedProductId id;
    @ManyToOne
    @MapsId("productId")
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @MapsId("orderId")
    @JoinColumn(name = "order_id")
    private Order order;
    private Integer quantity;
    private Double unitPrice;
    private Double totalPrice;
}
