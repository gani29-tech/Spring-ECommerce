package com.techouts.repositoryimplementation;

import com.techouts.entity.Cart;
import com.techouts.entity.CartItem;
import com.techouts.entity.User;
import com.techouts.repository.CartRepo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class CartRepoImplementation implements CartRepo {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Cart getCartByUser(User user) {
        List<Cart> carts = em.createQuery("SELECT c FROM Cart c WHERE c.user.id = :userId", Cart.class)
                .setParameter("userId", user.getId())
                .getResultList();
        return carts.isEmpty()?null:carts.get(0);
    }

    @Override
    @Transactional
    public void save(Cart cart) {
        if (cart.getId() == 0) em.persist(cart);
        else em.merge(cart);
    }

    @Override
    public CartItem getCartItemByProductId(long productId) {
        List<CartItem> cartItems = em.createQuery("from CartItem where product.id =:productId", CartItem.class)
                .setParameter("productId", productId).getResultList();
        return !cartItems.isEmpty() ? cartItems.get(0) : null;
    }

    @Override
    public CartItem getCartItemById(long id) {
        return em.find(CartItem.class, id);
    }
}