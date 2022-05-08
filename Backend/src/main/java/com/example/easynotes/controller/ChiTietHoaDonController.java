package com.example.easynotes.controller;


import com.ea.async.Async;
import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.service.ChiTietHoaDonService;
import com.example.easynotes.service.ChiTietThucPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api/chitiethoadon")
public class ChiTietHoaDonController  {

    @Autowired
    private ChiTietHoaDonService service;

    @Autowired
    private ChiTietThucPhamService chiTietThucPhamService;

    @GetMapping("/")
    public List<ChiTietHoaDon> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public ChiTietHoaDon addItem(@Valid @RequestBody ChiTietHoaDon chiTietHoaDon) {
        ChiTietThucPham chiTietThucPham = chiTietThucPhamService.getChiTietThucPhamHomNayTheoMaThucPham(chiTietHoaDon.getThucPham().getMaThucPham());
        if (chiTietThucPham != null){
            if (chiTietThucPham.getSoLuong() >0){
                int soLuong = chiTietThucPham.getSoLuong();
                ChiTietThucPham chiTietThucPham1 = chiTietThucPham;
                chiTietThucPham1.setSoLuong(soLuong-chiTietHoaDon.getSoLuong());
                chiTietThucPham = chiTietThucPham1;

                if (chiTietThucPhamService.update(chiTietThucPham, chiTietThucPham.getMaChiTietThucPham()) != null){

                    ChiTietHoaDon result = service.add(chiTietHoaDon);
                    if (result!=null){
                        return result;
                    }else{
                        return new ChiTietHoaDon();
                    }
                }else{
                    return new ChiTietHoaDon();
                }
            }else {
                return new ChiTietHoaDon();
            }
        }else
            return chiTietHoaDon;
    }

    @GetMapping("/{id}")
    public ChiTietHoaDon getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("ChiTietHoaDon", "maChiTietHoaDon", id);
        }
    }

    @PutMapping("/{id}")
    public ChiTietHoaDon update(@PathVariable(value = "id") Long id,
                      @Valid @RequestBody ChiTietHoaDon chiTietHoaDon) {
        ChiTietHoaDon rs = service.update(chiTietHoaDon, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("ChiTietHoaDon", "maChiTietHoaDon", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("ChiTietHoaDon", "maChiTietHoaDon", id);
        }
    }
    @GetMapping("/danhsachtheohoadon/{id}")
    public List<ChiTietHoaDon> getAllBymaHoaDon(@PathVariable(value = "id") Long id){
        return service.getAllByIdHoaDon(id);
    }
}
