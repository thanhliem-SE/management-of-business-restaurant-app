package com.example.easynotes.service;

import com.example.easynotes.dto.ThongKeMonAn;
import com.example.easynotes.model.ThanhToan;
import com.example.easynotes.model.ThucPham;
import com.example.easynotes.service.repository.ThucPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ThucPhamService {
    @Autowired
    private ThucPhamRepository repository;

    public List<ThucPham> getList(){
        return repository.getAll();
    }

    public ThucPham getById(Long id){
        return  repository.findById(id).get();
    }

    public ThucPham add(ThucPham thucPham){
        thucPham.setDeleted(false);
        thucPham.setTrangThai("CHUADUYET");
        return repository.save(thucPham);
    }

    public int deleteById(Long id){
        return repository.deleteThucPham(id);
    }

    public ThucPham update(ThucPham thucPham, Long id){
        if(getById(id) != null){
            thucPham.setMaThucPham(id);
            return  repository.save(thucPham);
        }
        return null;
    }



    public List<ThucPham> getListByDanhMuc(Long maDanhMuc){
        return repository.getThucPhamByDanhMuc(maDanhMuc);
    }

    public List<ThucPham> getListChuaDuyet(){
        return repository.getThucPhamChuaDuyet();
    }

    public List<ThongKeMonAn> getThongKeMonAnByThang(int thang, int nam){
        return repository.getThongKeMonAnByThang(thang, nam);
    }
}
