package com.example.easynotes.service;

import com.example.easynotes.model.KhachHang;
import com.example.easynotes.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepository repository;

    public List<KhachHang> getList(){
        return repository.findAll();
    }

    public KhachHang getById(Long id){
        return  repository.getById(id);
    }

    public KhachHang add(KhachHang khachHang){
        return repository.save(khachHang);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public KhachHang update(KhachHang khachHang, Long id){
        if(getById(id) != null){
            khachHang.setMaKhachHang(id);
            return  repository.save(khachHang);
        }
        return null;
    }
}
