package com.example.easynotes.service;

import com.example.easynotes.model.NhaCungCap;
import com.example.easynotes.repository.NhaCungCapRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NhaCungCapService {
    @Autowired
    private NhaCungCapRepository repository;

    public List<NhaCungCap> getList(){
        return repository.findAll();
    }

    public NhaCungCap getById(Long id){
        return  repository.findById(id).get();
    }

    public NhaCungCap add(NhaCungCap nhaCungCap){
        return repository.save(nhaCungCap);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public NhaCungCap update(NhaCungCap nhaCungCap, Long id){
        if(getById(id) != null){
           nhaCungCap.setMaNhaCungCap(id);
            return  repository.save(nhaCungCap);
        }
        return null;
    }
}
