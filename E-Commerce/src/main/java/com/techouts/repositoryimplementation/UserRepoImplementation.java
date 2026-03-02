package com.techouts.repositoryimplementation;

import com.techouts.entity.User;
import com.techouts.repository.UserRepo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepoImplementation implements UserRepo {

    @PersistenceContext
    private EntityManager em;

    @Override
    public User findById(Long id) {
        return em.find(User.class, id);
    }

    @Override
    @Transactional
    public void save(User user) {
        em.persist(user);
    }

    @Override
    public User findByUsername(String username) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public boolean emailExists(String email, long id) {
        List<User> users = em.createQuery("From User u where email=:email and id<>:id", User.class)
                .setParameter("email", email)
                .setParameter("id", id)
                .getResultList();
        return !users.isEmpty();
    }

    @Override
    public boolean usernameExists(String username, long id) {
        List<User> users = em.createQuery("From User u where username=:username and id<>:id", User.class)
                .setParameter("username", username)
                .setParameter("id", id)
                .getResultList();
        return !users.isEmpty();
    }

    @Override
    public User findByEmail(String email) {
        try {
            return em.createQuery("Select u from User u Where u.email=:email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}