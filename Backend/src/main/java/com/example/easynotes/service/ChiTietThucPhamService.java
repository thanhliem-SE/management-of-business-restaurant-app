package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.ThucPham;
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

    @Autowired
    private ThucPhamService thucPhamService;

    public List<ChiTietThucPham> getList(){
        return repository.getAll();
    }

    public ChiTietThucPham getById(Long id){
        return  repository.findById(id).get();
    }

    public ChiTietThucPham add(ChiTietThucPham chiTietThucPham){
        chiTietThucPham.setDeleted(false);
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

    public List<ChiTietThucPham> taoChiTietThucPhamHomNayTheoDanhMuc( Long maDanhMuc){
        List<ThucPham> thucPhamList = thucPhamService.getListByDanhMuc(maDanhMuc);
        List<ChiTietThucPham> chiTietThucPhamList = new ArrayList<>();
        for (int i = 0; i < thucPhamList.size(); i++) {
            ChiTietThucPham chiTietThucPham = new ChiTietThucPham();
            chiTietThucPham.setThucPham(thucPhamList.get(i));
            chiTietThucPham.setSoLuong(0);
            chiTietThucPham.setDeleted(false);
            chiTietThucPhamList.add(repository.save(chiTietThucPham));
            if (i == thucPhamList.size() - 1 ){
                return chiTietThucPhamList;
            }
        }
        return chiTietThucPhamList;
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
