package com.techouts.controller;

import com.sun.net.httpserver.HttpServer;
import com.techouts.entity.Product;
import com.techouts.entity.User;
import com.techouts.service.ProductService;
import com.techouts.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/")
public class UserController {


    private final UserService userService;
    private final UserDetailsService userDetailsService;
    private final ProductService productService;

    public UserController(UserService userService, UserDetailsService userDetailsService, ProductService productService) {
        this.userService = userService;
        this.userDetailsService = userDetailsService;
        this.productService = productService;
    }

    @GetMapping("/signup")
    public String signupForm() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(@ModelAttribute User user1,
                         Model model,
                         HttpSession session,
                         HttpServletRequest request) {
        try {


            String rawPassword = user1.getPassword();


            User savedUser = userService.saveUser(user1);

            request.login(savedUser.getUsername(), rawPassword);

            session.setAttribute("user", savedUser);

            return "redirect:/home";

        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "signup";
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/home")
    public String home(HttpSession session, Model model, @AuthenticationPrincipal User u,
                       @RequestParam(name = "category", defaultValue = "All") String category) {
        User user = userService.getUserById(u.getId());
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

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "index";
    }

    @GetMapping("/user/update")
    public String updateUserForm(Model model, @AuthenticationPrincipal User u,HttpSession session) {
        User user = userService.getUserById(u.getId());
        model.addAttribute("user", user);
        return "user_update";
    }

    @PostMapping("/user/update")
    public String updateUser(@ModelAttribute User user, Model model, HttpSession session) {
        try {
            userService.updateUser(user);
            session.setAttribute("user",userService.getUserById(user.getId()));
            session.setAttribute("message", "User updated successfully");
            return "redirect:/home";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "user_update";
        }
    }
}