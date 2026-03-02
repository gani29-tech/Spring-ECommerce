package com.techouts.controller;

import com.techouts.entity.Product;
import com.techouts.entity.User;
import com.techouts.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/")
public class ProductController {

    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/list")
    public String home(HttpSession session, Model model,
                       @RequestParam(name = "category", defaultValue = "All") String category) {
        User user = (User) session.getAttribute("user");
        List<Product> products;
        if (category.equalsIgnoreCase("All"))
            products = productService.getAllProducts();
        else
            products = productService.getProductsByCategory(category);
        session.setAttribute("user", user);
        model.addAttribute("user", user);
        model.addAttribute("categories", productService.getAllCategories().stream().distinct().sorted().toList());
        model.addAttribute("products", products);
        model.addAttribute("selectedCategory", category);
        Object message = session.getAttribute("message");
        if (message != null) {
            model.addAttribute("message", message.toString());
            session.removeAttribute("message");
        }
        return "home";
    }

    @GetMapping("/product/details/{id}")
    public String productDetails(@PathVariable(value = "id") long id, Model model,HttpSession session) {
        Product product = productService.getProductById(id);
        User user =  (User) session.getAttribute("user");
        if (product == null) {
            return "redirect:/product/list";
        }
        model.addAttribute("product", product);
        model.addAttribute("user", user);
        return "product/product_details";
    }

    @GetMapping("/admin/add")
    public String addProductForm(Model model) {
        model.addAttribute("product", new Product());
        return "product/product_add";
    }

    @PostMapping("/admin/add")
    public String addProduct(@ModelAttribute Product product,
                             @RequestParam("imageFile") MultipartFile imageFile, Model model) {
        try {
            productService.addProduct(product, imageFile);
            return "redirect:/product/list";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "product/product_add";
        }
    }

    @GetMapping("/admin/update/{id}")
    public String updateProductForm(@PathVariable(value = "id") long id, Model model) {
        Product product = productService.getProductById(id);
        if (product == null) {
            return "redirect:/home";
        }
        model.addAttribute("product", product);
        return "product/product_update";
    }

    @PostMapping("/admin/update")
    public String updateProduct(@ModelAttribute Product product,
                                @RequestParam("imageFile") MultipartFile imageFile, Model model) {
        try {
            productService.updateProduct(product, imageFile);
            return "redirect:/product/list";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "product/product_update";
        }
    }

    @GetMapping("/admin/delete/{id}")
    public String deleteProduct(@PathVariable(value = "id") long id) {
        Product product = productService.getProductById(id);
        if (product != null) {
            productService.deleteProduct(product);
        }
        return "redirect:/home";
    }
}