package com.example.easynotes.service;

import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.repository.TaiKhoanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaiKhoanService {
    @Autowired
    private TaiKhoanRepository repository;

    @Autowired
    PasswordEncoder passwordEncoder;

    public List<TaiKhoan> getList(){
        return repository.findAll();
    }

    public TaiKhoan getByTenTaiKhoan(String tenTaiKhoan){
        return  repository.findById(tenTaiKhoan).get();
    }

    public TaiKhoan add(TaiKhoan taiKhoan){
        String password = passwordEncoder.encode(taiKhoan.getMatKhau());
        taiKhoan.setMatKhau(password);
        return repository.save(taiKhoan);
    }

    public void deleteByTenTaiKhoan(String tenTaiKhoan){
        repository.deleteById(tenTaiKhoan);
    }

    public TaiKhoan update(TaiKhoan taiKhoan, String tenTaiKhoan){
        if(getByTenTaiKhoan(tenTaiKhoan) != null){
            taiKhoan.setTenTaiKhoan(tenTaiKhoan);
            return  repository.save(taiKhoan);
        }
        return null;
    }

}
