package com.techouts.service;

import com.techouts.entity.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductService {
    void addProduct(Product product, MultipartFile imageFile);

    void updateProduct(Product product, MultipartFile imageFile);

    void deleteProduct(Product product);

    Product getProductById(Long id);

    List<Product> getAllProducts();

    List<String> getAllCategories();

    List<Product> getProductsByCategory(String category);
}