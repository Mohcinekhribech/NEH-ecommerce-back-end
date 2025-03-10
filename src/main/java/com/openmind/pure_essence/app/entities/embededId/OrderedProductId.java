package com.openmind.pure_essence.app.entities.embededId;

import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderedProductId implements Serializable {
    private UUID productId;
    private UUID orderId;
}
