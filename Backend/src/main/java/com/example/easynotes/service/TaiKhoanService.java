package com.example.easynotes.service;

import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.repository.TaiKhoanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaiKhoanService {
    @Autowired
    private TaiKhoanRepository repository;

    public List<TaiKhoan> getList(){
        return repository.findAll();
    }

    public TaiKhoan getById(String tenTaiKhoan){
        return  repository.getById(tenTaiKhoan);
    }

    public TaiKhoan add(TaiKhoan taiKhoan){
        return repository.save(taiKhoan);
    }

    public void deleteById(String tenTaiKhoan){
        repository.deleteById(tenTaiKhoan);
    }

    public TaiKhoan update(TaiKhoan taiKhoan, String tenTaiKhoan){
        if(getById(tenTaiKhoan) != null){
            taiKhoan.setTenTaiKhoan(tenTaiKhoan);
            return  repository.save(taiKhoan);
        }
        return null;
    }
}
