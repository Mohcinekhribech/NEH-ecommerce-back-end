package com.openmind.neh.app.entities.embededId;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@Embeddable
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Getter
@Setter
public class ProductTagId implements Serializable {
    @Column(name = "product_id")
    private UUID productId;

    @Column(name = "tag_id")
    private UUID tagId;
}