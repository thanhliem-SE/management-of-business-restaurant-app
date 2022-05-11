package com.example.easynotes.service;

import com.example.easynotes.model.Ban;
import com.example.easynotes.model.ChiTietHoaDon;
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
        List<Ban> list = repository.getAll();
        for(int i = 0; i < list.size(); i++){
            if(list.get(i).isDeleted())
                list.remove(i);
        }
        return list;
    }

    public Ban getById(Long id){
        Ban item =  repository.findById(id).get();
        return item.isDeleted() ? null: item;
    }

    public Ban add(Ban ban){
        ban.setDeleted(false);
        return repository.save(ban);
    }

    public void deleteById(Long id){
        Ban ban = getById(id);
        ban.setDeleted(true);
        repository.save(ban);
    }

    public Ban update(Ban ban, Long id){
        if(getById(id) != null){
            ban.setMaSoBan(id);
            return  repository.save(ban);
        }
        return null;
    }


}
