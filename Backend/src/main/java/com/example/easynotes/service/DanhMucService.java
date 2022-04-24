package com.example.easynotes.service;

import com.example.easynotes.model.DanhMuc;
import com.example.easynotes.service.repository.DanhMucRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DanhMucService {
    @Autowired
    private DanhMucRepository repository;

    public List<DanhMuc> getList(){
        return repository.findAll();
    }

    public DanhMuc getById(Long id){
        return  repository.findById(id).get();
    }

    public DanhMuc add(DanhMuc danhMuc){
        return repository.save(danhMuc);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public DanhMuc update(DanhMuc danhMuc, Long id){
        if(getById(id) != null){
            danhMuc.setMaDanhMuc(id);
            return  repository.save(danhMuc);
        }
        return null;
    }
}
