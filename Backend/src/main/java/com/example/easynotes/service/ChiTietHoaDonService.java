package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.service.repository.ChiTietHoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChiTietHoaDonService {
    @Autowired
    private ChiTietHoaDonRepository repository;

    public List<ChiTietHoaDon> getList(){
        return repository.findAll();
    }

    public ChiTietHoaDon getById(Long id){
        return  repository.findById(id).get();
    }

    public ChiTietHoaDon add(ChiTietHoaDon chiTietHoaDon){
        return repository.save(chiTietHoaDon);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public ChiTietHoaDon update(ChiTietHoaDon chiTietHoaDon, Long id){
        if(getById(id) != null){
            chiTietHoaDon.setMaChiTietHoaDon(id);
            return  repository.save(chiTietHoaDon);
        }
        return null;
    }

    public List<ChiTietHoaDon> getAllByIdHoaDon(Long maHoaDon){
        return repository.getChiTietHoaDonByMaHoaDon(maHoaDon);
    }
}
