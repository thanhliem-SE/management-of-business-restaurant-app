package com.example.easynotes.service;

import com.example.easynotes.model.Ban;
import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.service.repository.ChiTietHoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ChiTietHoaDonService {
    @Autowired
    private ChiTietHoaDonRepository repository;

    public List<ChiTietHoaDon> getList(){
        List<ChiTietHoaDon> list = repository.getAll();
        for(int i = 0; i < list.size(); i++){
            if(list.get(i).isDeleted())
                list.remove(i);
        }
        return list;
    }

    public ChiTietHoaDon getById(Long id){
        ChiTietHoaDon item =  repository.findById(id).get();
        return item.isDeleted() ? null : item;
    }

    public ChiTietHoaDon add(ChiTietHoaDon chiTietHoaDon){
        chiTietHoaDon.setDeleted(false);
        return repository.save(chiTietHoaDon);
    }

    public void deleteById(Long id){
        ChiTietHoaDon chiTietHoaDon = getById(id);
        chiTietHoaDon.setDeleted(true);
        repository.save(chiTietHoaDon);
    }

    public ChiTietHoaDon update(ChiTietHoaDon chiTietHoaDon, Long id){
        if(getById(id) != null){
            chiTietHoaDon.setMaChiTietHoaDon(id);
            return  repository.save(chiTietHoaDon);
        }
        return null;
    }

    public List<ChiTietHoaDon> getAllByIdHoaDon(Long maHoaDon){
        List<ChiTietHoaDon> list = repository.getChiTietHoaDonByMaHoaDon(maHoaDon);
        for(int i = 0; i < list.size(); i++){
            if(list.get(i).isDeleted())
                list.remove(i);
        }
        return list;
    }
}
