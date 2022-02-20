package com.example.easynotes.service;

import com.example.easynotes.model.ThanhToan;
import com.example.easynotes.repository.ThanhToanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThanhToanService {
    @Autowired
    private ThanhToanRepository repository;

    public List<ThanhToan> getList(){
        return repository.findAll();
    }

    public ThanhToan getById(Long id){
        return  repository.findById(id).get();
    }

    public ThanhToan add(ThanhToan thanhToan){
        return repository.save(thanhToan);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public ThanhToan update(ThanhToan thanhToan, Long id){
        if(getById(id) != null){
            thanhToan.setMaThanhToan(id);
            return  repository.save(thanhToan);
        }
        return null;
    }
}
