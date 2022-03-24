package com.example.easynotes.model;

import lombok.Data;

@Data
public class JwtBody {
    String sub;
    String iat;
    String exp;
}
