package com.techouts.serviceimplementation;

import com.techouts.entity.Order;
import com.techouts.entity.User;
import com.techouts.repository.OrderRepo;
import com.techouts.service.OrderService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImplementation implements OrderService {

    private final OrderRepo orderRepo;

    public OrderServiceImplementation(OrderRepo orderRepo) {
        this.orderRepo = orderRepo;
    }

    @Override
    public Order getOrderById(long id) {
        return orderRepo.getOrderById(id);
    }

    @Override
    public List<Order> getOrdersByUser(User user) {
        return orderRepo.getOrdersByUser(user);
    }

    @Override
    @Transactional
    public boolean cancelOrder(long orderId) {
        Order order = orderRepo.getOrderById(orderId);
        if (order != null) order.setStatus("CANCELLED");
        orderRepo.save(order);
        return true;
    }
}