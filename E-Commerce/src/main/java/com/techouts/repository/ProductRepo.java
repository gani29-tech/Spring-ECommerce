package com.techouts.repository;

import com.techouts.entity.Product;

import java.util.List;

public interface ProductRepo {
    void addProduct(Product product);

    void updateProduct(Product product);

    void deleteProduct(Product product);

    boolean productExists(String name, long id);

    Product findById(Long id);

    List<Product> findAll();

    List<String> getAllCategories();
}