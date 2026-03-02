package com.techouts.serviceimplementation;

import com.techouts.entity.*;
import com.techouts.repository.CartRepo;
import com.techouts.repository.OrderRepo;
import com.techouts.service.CartService;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class CartServiceImplementation implements CartService {

    private final CartRepo cartRepo;
    private final OrderRepo orderRepo;

    public CartServiceImplementation(CartRepo cartRepo, OrderRepo orderRepo) {
        this.cartRepo = cartRepo;
        this.orderRepo = orderRepo;
    }

    @Override
    public Cart getCartByUser(User user) {
        Cart cart = cartRepo.getCartByUser(user);
        if (cart == null) {
            cart = new Cart();
            cart.setUser(user);
            cartRepo.save(cart);
        }
        return cart;
    }

    @Override
    @Transactional
    public void addCartItem(User user, Product product) {
        Cart cart = cartRepo.getCartByUser(user);
        boolean productExists = false;
        for (CartItem item : cart.getCartItems()) {
            if (item.getProduct().getId() == product.getId()) {
                item.setQuantity(item.getQuantity() + 1);
                productExists = true;
                cartRepo.save(cart);
                break;
            }
        }
        if (!productExists) {
            CartItem item = new CartItem();
            item.setProduct(product);
            item.setQuantity(1);
            item.setCart(cart);
            cart.getCartItems().add(item);
            cartRepo.save(cart);
        }
    }

    @Override
    @Transactional
    public void updateCartItem(long itemId, int quantity) {
        CartItem item = getCartItemById(itemId);
        if (item != null) {
            item.setQuantity(quantity);
        }
    }

    @Override
    @Transactional
    public void removeCartItem(long itemId) {
        CartItem item = getCartItemById(itemId);
        if (item != null) {
            Cart cart = item.getCart();
            cart.getCartItems().remove(item);
            cartRepo.save(cart);
        }
    }

    @Override
    @Transactional
    public void checkout(User user, CheckoutRequest request) {
        Cart cart = getCartByUser(user);
        if (cart.getCartItems().isEmpty()) return;
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());
        order.setCity(request.getCity());
        order.setAddress(request.getAddress());
        order.setState(request.getState());
        order.setPincode(request.getPincode());
        order.setPaymentType(request.getPaymentType());
        order.setStatus("PLACED");
        for (CartItem item : cart.getCartItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(item.getProduct());
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(item.getProduct().getPrice() * item.getQuantity());
            order.getOrderItems().add(orderItem);
            orderItem.setOrder(order);
        }
        double total = cart.getTotalPrice();
        order.setTotalAmount(total);
        orderRepo.save(order);
        cart.getCartItems().clear();
        cartRepo.save(cart);
    }

    @Override
    @Transactional
    public void buyNow(User user, Product product, CheckoutRequest request) {
        OrderItem orderItem = new OrderItem();
        orderItem.setProduct(product);
        orderItem.setQuantity(1);
        orderItem.setPrice(product.getPrice());
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());
        order.setCity(request.getCity());
        order.setAddress(request.getAddress());
        order.setState(request.getState());
        order.setPincode(request.getPincode());
        order.setPaymentType(request.getPaymentType());
        order.setStatus("PLACED");
        order.getOrderItems().add(orderItem);
        order.setTotalAmount(product.getPrice());
        orderItem.setOrder(order);
        orderRepo.save(order);
    }

    private CartItem getCartItemById(long id) {
        return cartRepo.getCartItemById(id);
    }
}