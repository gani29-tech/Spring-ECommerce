package com.techouts.service;

import com.techouts.entity.*;

public interface CartService {
    Cart getCartByUser(User user);

    void addCartItem(User user, Product product);

    void updateCartItem(long itemId, int quantity);

    void removeCartItem(long itemId);

    void checkout(User user, CheckoutRequest request);

    void buyNow(User user, Product product, CheckoutRequest request);
}