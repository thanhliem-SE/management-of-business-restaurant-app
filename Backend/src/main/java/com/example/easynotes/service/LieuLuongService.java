package com.example.easynotes.service;

import com.example.easynotes.model.LieuLuong;
import com.example.easynotes.repository.LieuLuongRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LieuLuongService {
    @Autowired
    private LieuLuongRepository repository;

    public List<LieuLuong> getList(){
        return repository.findAll();
    }

    public LieuLuong getById(Long id){
        return  repository.getById(id);
    }

    public LieuLuong add(LieuLuong lieuLuong){
        return repository.save(lieuLuong);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public LieuLuong update(LieuLuong lieuLuong, Long id){
        if(getById(id) != null){
            lieuLuong.setMaLieuLuong(id);
            return  repository.save(lieuLuong);
        }
        return null;
    }

}
