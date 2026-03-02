package com.techouts.repositoryimplementation;

import com.techouts.entity.Product;
import com.techouts.repository.ProductRepo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class ProductRepoImplementation implements ProductRepo {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void addProduct(Product product) {
        em.persist(product);
    }

    @Override
    public void updateProduct(Product product) {
        em.merge(product);
    }

    @Override
    public void deleteProduct(Product product) {
        em.createQuery("delete from CartItem where product.id = :id")
                .setParameter("id", product.getId())
                .executeUpdate();
        em.createQuery("delete from OrderItem where product.id = :id")
                .setParameter("id", product.getId())
                .executeUpdate();
        em.remove(em.contains(product) ? product : em.merge(product));
    }

    @Override
    public Product findById(Long id) {
        return em.find(Product.class, id);
    }

    @Override
    public List<Product> findAll() {
        return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
    }

    @Override
    public List<String> getAllCategories() {
        return em.createQuery("SELECT c.category FROM Product c", String.class).getResultList();
    }

    @Override
    public boolean productExists(String name, long id) {
        List<Product> product = em.createQuery("from Product where name = :name and id<>:id", Product.class)
                .setParameter("name", name)
                .setParameter("id", id)
                .getResultList();
        return !product.isEmpty();
    }
}