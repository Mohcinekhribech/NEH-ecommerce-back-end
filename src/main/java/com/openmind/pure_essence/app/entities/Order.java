package com.openmind.pure_essence.app.entities;

import com.openmind.pure_essence.app.entities.enums.OrderStatus;
import com.openmind.pure_essence.app.entities.enums.PaymentMethod;
import com.openmind.pure_essence.app.entities.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String address;
    private String city;
    private String zipCode;
    private String country;
    private Boolean delivered;
    private Double totalPrice;
    @Enumerated(EnumType.STRING)
    private OrderStatus status;       // Current status of the order

    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus; // Current payment status of the order

    @Enumerated(EnumType.STRING)
    private PaymentMethod paymentMethod; // Payment method used for the order
    @ManyToOne
    @JoinColumn(name = "client_id")
    private Client client;
    @OneToMany(mappedBy = "order")
    private List<OrderedProduct> orderedProducts;
    @Column(nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreationTimestamp
    private LocalDateTime createdAt;
}