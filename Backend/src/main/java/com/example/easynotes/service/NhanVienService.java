package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.model.NhanVien;
import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.service.repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class NhanVienService {
    @Autowired
    private NhanVienRepository repository;

    @Autowired
    private TaiKhoanService taiKhoanService;

    public List<NhanVien> getList() {
        return repository.getAll();
    }

    public NhanVien getById(Long id) {
        return repository.findById(id).get();
    }

    public NhanVien add(NhanVien nhanVien) {
        nhanVien.setDeleted(false);
//        TaiKhoan taiKhoan = taiKhoanService.add(nhanVien.getTaiKhoan());
//        if (taiKhoan != null){
//            return repository.save(nhanVien);
//        }
        return repository.save(nhanVien);
    }

    public NhanVien addNhanVienAndTaiKhoan(NhanVien nhanVien){
        nhanVien.setDeleted(false);
        TaiKhoan taiKhoan = taiKhoanService.add(nhanVien.getTaiKhoan());
        if (taiKhoan != null){
            return repository.save(nhanVien);
        }
        return new NhanVien();
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    public NhanVien update(NhanVien nhanVien, Long id) {
        if (getById(id) != null) {
            nhanVien.setMaNhanVien(id);
            return repository.save(nhanVien);
        }
        return null;
    }

    public NhanVien getByTenTaiKhoan(String tenTaiKhoan) {
        TaiKhoan taiKhoan = taiKhoanService.getByTenTaiKhoan(tenTaiKhoan);
        if (taiKhoan != null) {
            return repository.findByTaiKhoan(taiKhoan);
        }
        return null;
    }

    public List<NhanVien> getNhanVienTheoQuyen(String quyen){
        return repository.getNhanVienByQuyen(quyen);
    }
}
