package com.techouts.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "order_items")
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private int quantity;
    private double price;
    @ManyToOne
    private Order order;
    @ManyToOne(fetch = FetchType.EAGER)
    private Product product;
}
