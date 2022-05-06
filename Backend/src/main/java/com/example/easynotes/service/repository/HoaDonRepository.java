package com.example.easynotes.service.repository;

import com.example.easynotes.model.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {
    @Query(value = "select * from hoa_don where tinh_trang != 'DATHANHTOAN'", nativeQuery = true)
    public List<HoaDon> getHoaDonBeforePaymented();

    @Query(value = "select * from hoa_don where hoa_don.ma_so_ban = ?1 and hoa_don.tinh_trang in ('CHO', 'DANGCHEBIEN', 'HOANTHANH', 'CHUATHANHTOAN', 'HUY')", nativeQuery = true)
    public HoaDon getHoaDonDangPhucVuTaiBan(int maSoBan);
}
