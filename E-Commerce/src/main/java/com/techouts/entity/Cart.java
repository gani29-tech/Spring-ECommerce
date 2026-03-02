package com.techouts.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "My_cart")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    private List<CartItem> cartItems = new ArrayList<>();
    @OneToOne
    private User user;

    public double getTotalPrice() {
        return cartItems.stream()
                .mapToDouble(item ->
                        item.getProduct().getPrice() * item.getQuantity())
                .sum();
    }
}
