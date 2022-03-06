package com.example.easynotes.controller;


import com.example.easynotes.dto.LoginRequest;
import com.example.easynotes.jwt.JwtTokenProvider;
import com.example.easynotes.model.CustomUserDetails;
import com.example.easynotes.service.TaiKhoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/")
public class IndexController {
    @Autowired
    TaiKhoanService service;

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @GetMapping
    public String sayHello() {
        return "Hello and Welcome to the EasyNotes application. You can create a new Note by making a POST request to /api/notes endpoint.";
    }

    @PostMapping("/api/login")
    public String authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {

        System.out.println("==> loginRequest: " + loginRequest.toString());

        // Xác thực thông tin người dùng Request lên
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()
                )
        );

        // Nếu không xảy ra exception tức là thông tin hợp lệ
        // Set thông tin authentication vào Security Context
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // Trả về jwt cho người dùng.
        String jwt = tokenProvider.generateToken((CustomUserDetails) authentication.getPrincipal());
        return jwt;
    }
}
