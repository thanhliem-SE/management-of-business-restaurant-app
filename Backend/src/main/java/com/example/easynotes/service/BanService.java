package com.example.easynotes.service;

import com.example.easynotes.model.Ban;
import com.example.easynotes.repository.BanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BanService {
    @Autowired
    private BanRepository repository;

    public List<Ban> getList(){
        return repository.findAll();
    }

    public Ban getById(Long id){
        return  repository.getById(id);
    }

    public Ban add(Ban ban){
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
