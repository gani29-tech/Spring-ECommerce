package com.techouts.controller;

import com.techouts.entity.*;
import com.techouts.service.CartService;
import com.techouts.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;
    private final ProductService productService;

    public CartController(CartService cartService, ProductService productService) {
        this.cartService = cartService;
        this.productService = productService;
    }

    @GetMapping("/show")
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        Cart cart = cartService.getCartByUser(user);
        model.addAttribute("cart", cart);
        Object message = session.getAttribute("message");
        if (message != null) {
            model.addAttribute("message", message);
            session.removeAttribute("message");
        }
        return "cart/cart";
    }

    @GetMapping("/add/{productId}")
    public String addToCart(@PathVariable("productId") long productId, HttpSession session,@RequestParam("category") String category) {
        User user = (User) session.getAttribute("user");
        Product product = productService.getProductById(productId);
        cartService.addCartItem(user, product);
        session.setAttribute("message", "Product successfully added to cart");
        return "redirect:/home?category="+category;
    }







    @GetMapping("/add/details/{productId}")
    public String addProductToCart(@PathVariable("productId") long productId, HttpSession session,Model model) {
        User user = (User) session.getAttribute("user");
        Product product = productService.getProductById(productId);
        cartService.addCartItem(user, product);
        session.setAttribute("message", "Product successfully added to cart");
        model.addAttribute("product", product);
        return "product/product_details";
    }

    @PostMapping("/update/{itemId}")
    public String updateCartItem(@PathVariable(name = "itemId") long itemId, @RequestParam("quantity") int quantity, HttpSession session) {
        cartService.updateCartItem(itemId, quantity);
        session.setAttribute("message", "Product quantity successfully updated");
        return "redirect:/cart/show";
    }

    @PostMapping("/remove/{itemId}")
    public String removeCartItem(@PathVariable(name = "itemId") long itemId,HttpSession session) {
        cartService.removeCartItem(itemId);
        session.setAttribute("message", "Product successfully removed from cart");
        return "redirect:/cart/show";
    }

    @GetMapping("/checkout")
    public String checkoutForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Cart cart = cartService.getCartByUser(user);
        model.addAttribute("cart", cart);
        return "cart/checkout";
    }

    @PostMapping("/checkout")
    public String checkout(@ModelAttribute CheckoutRequest request, HttpSession session) {
        User user = (User) session.getAttribute("user");
        cartService.checkout(user, request);
        return "redirect:/order/success";
    }

    @GetMapping("/buynow/{productId}")
    public String buyNow(@PathVariable(name = "productId") long productId, Model model) {
        Product product = productService.getProductById(productId);
        model.addAttribute("orderItem", product);
        return "cart/buynow";
    }

    @PostMapping("/buynow")
    public String buyNow(@ModelAttribute CheckoutRequest request, HttpSession session, @RequestParam("productId") long productId) {
        User user = (User) session.getAttribute("user");
        Product product = productService.getProductById(productId);
        cartService.buyNow(user, product, request);
        return "redirect:/order/success";
    }
}