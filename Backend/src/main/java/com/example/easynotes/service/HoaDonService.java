package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.model.HoaDon;
import com.example.easynotes.service.repository.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HoaDonService {
    @Autowired
    private HoaDonRepository repository;

    public List<HoaDon> getList(){
       return repository.getAll();
    }

    public HoaDon getById(Long id){
        return  repository.findById(id).get();
    }

    public HoaDon add(HoaDon hoaDon){
        hoaDon.setDeleted(false);
     return repository.save(hoaDon);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public HoaDon update(HoaDon hoaDon, Long id){
        if(getById(id) != null){
            hoaDon.setMaHoaDon(id);
            return  repository.save(hoaDon);
        }
        return null;
    }
    public List<HoaDon> getHoaDonBeforePaymented(){
        return repository.getHoaDonBeforePaymented();
    }

    public HoaDon getHoaDonDangPhucVuTaiBan(int maSoBan){
        return repository.getHoaDonDangPhucVuTaiBan(maSoBan);
    }
}
