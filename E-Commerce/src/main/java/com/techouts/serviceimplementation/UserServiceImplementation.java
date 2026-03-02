package com.techouts.serviceimplementation;

import com.techouts.entity.Cart;
import com.techouts.entity.User;
import com.techouts.repository.UserRepo;
import com.techouts.service.UserService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userServiceImplementation")
public class UserServiceImplementation implements UserService, UserDetailsService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImplementation(UserRepo userRepo, PasswordEncoder passwordEncoder) {
        this.userRepo = userRepo;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User getUserById(Long id) {
        return userRepo.findById(id);
    }

    @Override
    @Transactional
    public User saveUser(User user) {
        if (userRepo.findByUsername(user.getUsername()) != null) {
            throw new IllegalArgumentException("Username already exists");
        }
        if (userRepo.findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        Cart cart = new Cart();
        cart.setUser(user);
        user.setCart(cart);
        userRepo.save(user);
        return user;
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        User existingUser = userRepo.findById(user.getId());
        if (userRepo.emailExists(user.getEmail(), user.getId())) {
            throw new IllegalArgumentException("Email already exists");
        }
        if (userRepo.usernameExists(user.getUsername(), user.getId())) {
            throw new IllegalArgumentException("Username already exists");
        }
        existingUser.setEmail(user.getEmail());
        existingUser.setUsername(user.getUsername());
        existingUser.setPhone(user.getPhone());
        existingUser.setAddress(user.getAddress());
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
        return user;
    }
}