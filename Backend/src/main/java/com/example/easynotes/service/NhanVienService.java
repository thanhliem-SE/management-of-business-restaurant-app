package com.example.easynotes.service;

import com.example.easynotes.model.NhanVien;
import com.example.easynotes.repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NhanVienService {
    @Autowired
    private NhanVienRepository repository;

    public List<NhanVien> getList(){
        return repository.findAll();
    }

    public NhanVien getById(Long id){
        return  repository.findById(id).get();
    }

    public NhanVien add(NhanVien nhanVien){
        return repository.save(nhanVien);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public NhanVien update(NhanVien nhanVien, Long id){
        if(getById(id) != null){
            nhanVien.setMaNhanVien(id);
            return  repository.save(nhanVien);
        }
        return null;
    }
}
