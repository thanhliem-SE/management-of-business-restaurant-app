package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.service.repository.ChiTietThucPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

@Service
public class ChiTietThucPhamService {
    @Autowired
    private ChiTietThucPhamRepository repository;

    public List<ChiTietThucPham> getList(){
        return repository.findAll();
    }

    public ChiTietThucPham getById(Long id){
        return  repository.findById(id).get();
    }

    public ChiTietThucPham add(ChiTietThucPham chiTietThucPham){
        return repository.save(chiTietThucPham);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public ChiTietThucPham update(ChiTietThucPham chiTietThucPham, Long id){
        if(getById(id) != null){
            chiTietThucPham.setMaChiTietThucPham(id);
            return  repository.save(chiTietThucPham);
        }
        return null;
    }

    public List<ChiTietThucPham> getChiTietThucPhamToday(){
        List<ChiTietThucPham> result = new ArrayList<>();
        SimpleDateFormat fmt = new SimpleDateFormat("ddMMyyyy");
       getList().forEach((item) -> {
          if(fmt.format(item.getCreatedAt()).equals(fmt.format(new Date()))){
              result.add(item);
          }
       });
       return result;
    }

    public ChiTietThucPham getChiTietThucPhamHomNayTheoMaThucPham(Long maThucPham){
        AtomicReference<ChiTietThucPham> result = new AtomicReference<>(new ChiTietThucPham());
        SimpleDateFormat fmt = new SimpleDateFormat("ddMMyyyy");
        getList().forEach((item) -> {
            if(fmt.format(item.getCreatedAt()).equals(fmt.format(new Date())) && item.getThucPham().getMaThucPham() == maThucPham){
                result.set(item);
            }
        });
        return result.get();
    }
}
