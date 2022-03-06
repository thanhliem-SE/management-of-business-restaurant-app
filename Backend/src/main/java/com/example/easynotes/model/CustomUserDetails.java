package com.example.easynotes.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Data
@AllArgsConstructor
public class CustomUserDetails implements UserDetails {
    private TaiKhoan taiKhoan;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        String ROLE_PREFIX = "ROLE_";
        List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();

        list.add(new SimpleGrantedAuthority(ROLE_PREFIX + taiKhoan.getQuyen()));

        return list;
    }

    @Override
    public String getPassword() {
        return taiKhoan.getMatKhau();
    }

    @Override
    public String getUsername() {
        return taiKhoan.getTenTaiKhoan();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }


}
