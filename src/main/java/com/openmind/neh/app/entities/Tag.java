package com.openmind.neh.app.entities;

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
    @OneToMany(mappedBy = "tag", cascade = CascadeType.ALL)
    private List<ProductTag> productTags = new ArrayList<>();

}
