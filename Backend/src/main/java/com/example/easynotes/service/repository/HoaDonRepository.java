package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {
    @Query(value = "select * from HoaDon where tinhTrang != 'DATHANHTOAN'", nativeQuery = true)
    public List<HoaDon> getHoaDonBeforePaymented();

    @Query(value = "select * from HoaDon where HoaDon.maSoBan = ?1 and HoaDon.tinhTrang in ('CHO', 'DANGCHEBIEN', 'HOANTHANH', 'KHONGTIEPNHAN', 'CHUATHANHTOAN', 'HUY', 'DACHEBIEN')", nativeQuery = true)
    public HoaDon getHoaDonDangPhucVuTaiBan(int maSoBan);

    @Query(value = "select * from HoaDon where daXoa = 0", nativeQuery = true)
    public List<HoaDon> getAll();

    @Query(value = "select * from HoaDon where daXoa = 0 and daTraHoaDon = 0 and tinhTrang = 'DATHANHTOAN'", nativeQuery = true)
    public List<HoaDon> getListChuaTraHoaDon();
}
