package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.repository.ChiTietThucPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChiTietThucPhamService {
    @Autowired
    private ChiTietThucPhamRepository repository;

    public List<ChiTietThucPham> getList(){
        return repository.findAll();
    }

    public ChiTietThucPham getById(Long id){
        return  repository.findById(id).get();
    }

    public ChiTietThucPham add(ChiTietThucPham chiTietThucPham){
        return repository.save(chiTietThucPham);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public ChiTietThucPham update(ChiTietThucPham chiTietThucPham, Long id){
        if(getById(id) != null){
            chiTietThucPham.setMaChiTietThucPham(id);
            return  repository.save(chiTietThucPham);
        }
        return null;
    }
}
