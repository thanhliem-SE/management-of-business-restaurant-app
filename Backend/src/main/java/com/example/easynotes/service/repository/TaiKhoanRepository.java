package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.NhanVien;
import com.example.easynotes.model.TaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaiKhoanRepository extends JpaRepository<TaiKhoan, String> {
    @Query(value = "select * from tai_khoan where is_deleted = 0", nativeQuery = true)
    public List<TaiKhoan> getAll();

    @Query(value = "select * from tai_khoan where quyen = ?1", nativeQuery = true)
    public List<TaiKhoan> getListTaiKhoanByQuyen(String quyen);
}
