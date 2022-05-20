package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.NhanVien;
import com.example.easynotes.model.TaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NhanVienRepository extends JpaRepository<NhanVien, Long> {
    public NhanVien findByTaiKhoan(TaiKhoan taiKhoan);

    @Query(value = "select * from nhan_vien where is_deleted = 0", nativeQuery = true)
    public List<NhanVien> getAll();

    @Query(value = "select nv.* from nhan_vien nv join tai_khoan tk on nv.ten_tai_khoan = tk.ten_tai_khoan where tk.quyen = ?1 and nv.is_deleted = 0", nativeQuery = true)
    public List<NhanVien> getNhanVienByQuyen(String quyen);
}
