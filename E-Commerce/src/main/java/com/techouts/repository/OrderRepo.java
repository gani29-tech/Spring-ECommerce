package com.techouts.repository;

import com.techouts.entity.Order;
import com.techouts.entity.User;

import java.util.List;

public interface OrderRepo {
    void save(Order order);

    Order getOrderById(long id);

    List<Order> getOrdersByUser(User user);
}