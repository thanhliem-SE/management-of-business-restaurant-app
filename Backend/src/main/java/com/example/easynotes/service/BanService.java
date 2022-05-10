package com.example.easynotes.service;

import com.example.easynotes.model.Ban;
import com.example.easynotes.service.repository.BanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BanService {
    @Autowired
    private BanRepository repository;
    public List<Ban> getList(){
        return repository.getAll();
    }

    public Ban getById(Long id){
        return  repository.findById(id).get();
    }

    public Ban add(Ban ban){
        ban.setDeleted(false);
        return repository.save(ban);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public Ban update(Ban ban, Long id){
        if(getById(id) != null){
            ban.setMaSoBan(id);
            return  repository.save(ban);
        }
        return null;
    }


}
