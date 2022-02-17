package com.example.easynotes.service;

import com.example.easynotes.model.LieuLuong;
import com.example.easynotes.model.NguyenLieu;
import com.example.easynotes.repository.LieuLuongRepository;
import com.example.easynotes.repository.NguyenLieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NguyenLieuService {
    @Autowired
    private NguyenLieuRepository repository;

    public List<NguyenLieu> getList(){
        return repository.findAll();
    }

    public NguyenLieu getById(Long id){
        return  repository.getById(id);
    }

    public NguyenLieu add(NguyenLieu nguyenLieu){
        return repository.save(nguyenLieu);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public NguyenLieu update(NguyenLieu nguyenLieu,Long id){
        if(getById(id) != null){
           nguyenLieu.setMaNguyenLieu(id);
            return  repository.save(nguyenLieu);
        }
        return null;
    }
}
