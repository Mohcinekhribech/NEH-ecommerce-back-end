package com.openmind.neh.app.entities;

import com.openmind.neh.app.entities.embededId.ProductTagId;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "product_tags")
public class ProductTag {
    @EmbeddedId
    private ProductTagId id = new ProductTagId();

    @ManyToOne
    @MapsId("productId")
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @MapsId("tagId")
    @JoinColumn(name = "tag_id")
    private Tag tag;
}