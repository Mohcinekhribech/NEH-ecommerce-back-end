package com.openmind.neh.app.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String name;
    @Size(max = 2000, message = "La description ne peut pas dépasser 2000 caractères")
    private String description;
    @Size(max = 2000, message = "La benefits ne peut pas dépasser 2000 caractères")
    private String benefits;
    @Size(max = 2000, message = "La howToUse ne peut pas dépasser 2000 caractères")
    private String howToUse;
    private Double purchasePrice;
    private Double finalPrice;
    private Integer quantity;
    private Double weight;
    @OneToMany(mappedBy = "product",cascade = CascadeType.ALL)
    private List<ProductTag> productTags;
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;
    @OneToMany(mappedBy = "product",cascade = CascadeType.ALL)
    private List<ProductMedia> medias = new ArrayList<>();
    @OneToMany(mappedBy = "product",cascade = CascadeType.ALL)
    private List<OrderedProduct> orderedProducts;

    public void addTag(Tag tag) {
        ProductTag productTag = new ProductTag();
        productTag.setProduct(this);
        productTag.setTag(tag);
        this.productTags.add(productTag);
    }

}
