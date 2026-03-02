package com.techouts.repository;

import com.techouts.entity.Cart;
import com.techouts.entity.CartItem;
import com.techouts.entity.User;

public interface CartRepo{
    Cart getCartByUser(User user);

    void save(Cart cart);

    CartItem getCartItemByProductId(long productId);

    CartItem getCartItemById(long id);
}