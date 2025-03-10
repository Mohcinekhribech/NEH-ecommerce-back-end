package com.openmind.pure_essence.app.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
public class Tag {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String name;
    @ManyToMany(mappedBy = "tags", fetch = FetchType.LAZY,cascade = CascadeType.REMOVE)
    private List<Product> products = new ArrayList<>();

}
