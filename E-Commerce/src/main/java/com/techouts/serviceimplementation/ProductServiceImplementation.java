package com.techouts.serviceimplementation;

import com.techouts.entity.Product;
import com.techouts.repository.ProductRepo;
import com.techouts.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class ProductServiceImplementation implements ProductService {

    private final ProductRepo productRepo;
    private final String uploadDir = "C:/Users/tech/IdeaProjects/Advanced-Java/Spring/E-Commerce/uploads";

    @Autowired
    public ProductServiceImplementation(ProductRepo productRepo) {
        this.productRepo = productRepo;
    }

    @Override
    public void addProduct(Product product, MultipartFile imageFile) {
        try {
            if (!imageFile.isEmpty()) {
                String filename = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                saveFile(imageFile, filename);
                product.setImage(filename);
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to add product image", e);
        }
        if (productRepo.productExists(product.getName(), product.getId())) {
            throw new IllegalArgumentException("Product already exists");
        }
        productRepo.addProduct(product);
    }

    @Override
    public void updateProduct(Product product, MultipartFile imageFile) {
        try {
            if (!imageFile.isEmpty()) {
                Product existing = getProductById(product.getId());
                if (existing != null && existing.getImage() != null) {
                    deleteFile(existing.getImage());
                }
                String filename = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                saveFile(imageFile, filename);
                product.setImage(filename);
            } else {
                Product existing = getProductById(product.getId());
                if (existing != null) {
                    product.setImage(existing.getImage());
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to update product image", e);
        }
        if (productRepo.productExists(product.getName(), product.getId())) {
            throw new IllegalArgumentException("Product already exists");
        }
        productRepo.updateProduct(product);
    }

    @Override
    public void deleteProduct(Product product) {
        if (product.getImage() != null) {
            deleteFile(product.getImage());
        }
        productRepo.deleteProduct(product);
    }

    @Override
    public Product getProductById(Long id) {
        return productRepo.findById(id);
    }

    @Override
    public List<Product> getAllProducts() {
        return productRepo.findAll();
    }

    @Override
    public List<String> getAllCategories() {
        return productRepo.getAllCategories();
    }

    @Override
    public List<Product> getProductsByCategory(String category) {
        return getAllProducts().stream()
                .filter(p -> category.equalsIgnoreCase(p.getCategory()))
                .toList();
    }

    private void saveFile(MultipartFile file, String filename) throws IOException {
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) uploadFolder.mkdirs();
        File dest = new File(uploadFolder, filename);
        file.transferTo(dest);
    }

    private void deleteFile(String filename) {
        File file = new File(uploadDir, filename);
        if (file.exists()) {
            file.delete();
        }
    }
}