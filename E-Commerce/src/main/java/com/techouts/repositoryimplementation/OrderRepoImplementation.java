package com.techouts.repositoryimplementation;

import com.techouts.entity.Order;
import com.techouts.entity.User;
import com.techouts.repository.OrderRepo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class OrderRepoImplementation implements OrderRepo {

    @PersistenceContext
    private EntityManager em;

    @Override
    @Transactional
    public void save(Order order) {
        if (order.getId() == 0) em.persist(order);
        else em.merge(order);
    }

    @Override
    public Order getOrderById(long id) {
        return em.find(Order.class, id);
    }

    @Override
    public List<Order> getOrdersByUser(User user) {
        return em.createQuery("SELECT o FROM Order o WHERE o.user.id = :userId", Order.class)
                .setParameter("userId", user.getId())
                .getResultList();
    }

}