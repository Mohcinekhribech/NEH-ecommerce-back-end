package com.openmind.pure_essence.app.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Entity
@Getter
@Setter
public class ProductMedia {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String mediaName;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
