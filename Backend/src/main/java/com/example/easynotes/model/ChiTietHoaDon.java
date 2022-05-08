package com.example.easynotes.model;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt"}, allowGetters = true)
@Entity
public class ChiTietHoaDon implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maChiTietHoaDon;

    @ManyToOne
    @JoinColumn(name = "maThucPham")
    private ThucPham thucPham;

    @Min(value = 1)
    private int soLuong;

    @ManyToOne
    @JoinColumn(name = "maNhanVien")
    private NhanVien nguoiCheBien;

    private boolean daCheBien;

    @ManyToOne
    @JoinColumn(name = "maHoaDon")
    private HoaDon hoaDon;

    @Column(nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;

    public ChiTietHoaDon(ThucPham thucPham, int soLuong,HoaDon hoaDon, Date createdAt, Date updatedAt) {
        this.thucPham = thucPham;
        this.soLuong = soLuong;
        this.hoaDon = hoaDon;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public ChiTietHoaDon() {

    }

    private double tinhThanhTien() {
        return this.thucPham.getGiaTien() * this.soLuong;
    }

    public Long getMaChiTietHoaDon() {
        return maChiTietHoaDon;
    }

    public void setMaChiTietHoaDon(Long maChiTietHoaDon) {
        this.maChiTietHoaDon = maChiTietHoaDon;
    }

    public ThucPham getThucPham() {
        return thucPham;
    }

    public void setThucPham(ThucPham thucPham) {
        this.thucPham = thucPham;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public double getThanhTien() {
        return this.soLuong * this.thucPham.getGiaTien();
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public HoaDon getHoaDon() {
        return hoaDon;
    }

    public void setHoaDon(HoaDon hoaDon) {
        this.hoaDon = hoaDon;
    }

    public boolean isDaCheBien() {
        return daCheBien;
    }

    public void setDaCheBien(boolean daCheBien) {
        this.daCheBien = daCheBien;
    }

    public NhanVien getNguoiCheBien() {
        return nguoiCheBien;
    }

    public void setNguoiCheBien(NhanVien nguoiCheBien) {
        this.nguoiCheBien = nguoiCheBien;
    }
}
