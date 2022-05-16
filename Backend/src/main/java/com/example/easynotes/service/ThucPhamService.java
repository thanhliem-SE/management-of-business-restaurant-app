package com.example.easynotes.service;

import com.example.easynotes.model.ThanhToan;
import com.example.easynotes.model.ThucPham;
import com.example.easynotes.service.repository.ThucPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ThucPhamService {
    @Autowired
    private ThucPhamRepository repository;

    public List<ThucPham> getList(){
        return repository.getAll();
    }

    public ThucPham getById(Long id){
        return  repository.findById(id).get();
    }

    public ThucPham add(ThucPham thucPham){
        thucPham.setDeleted(false);
        return repository.save(thucPham);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public ThucPham update(ThucPham thucPham, Long id){
        if(getById(id) != null){
            thucPham.setMaThucPham(id);
            return  repository.save(thucPham);
        }
        return null;
    }

    public List<ThucPham> getListByDanhMuc(Long maDanhMuc){
        return repository.getThucPhamByDanhMuc(maDanhMuc);
    }
}
