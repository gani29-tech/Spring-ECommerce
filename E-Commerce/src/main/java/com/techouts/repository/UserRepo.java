package com.techouts.repository;

import com.techouts.entity.User;

public interface UserRepo {
    User findById(Long id);

    User findByEmail(String email);

    void save(User user);

    User findByUsername(String username);

    boolean emailExists(String email, long id);

    boolean usernameExists(String username, long id);
}