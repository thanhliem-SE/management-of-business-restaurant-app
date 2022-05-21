package com.example.easynotes.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt"}, allowGetters = true)
@Entity
@Table(name = HoaDon.TABLE_NAME)
public class HoaDon implements Serializable {
    public static final String TABLE_NAME= "HoaDon";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maHoaDon;

    @ManyToOne
    @JoinColumn(name = "maNhanVien")
    private NhanVien nguoiLapHoaDon;

    @Column(name = "daXoa")
    private boolean isDeleted;

    @OneToOne
    @JoinColumn(name = "maThanhToan")
    private ThanhToan thanhToan;

    @JsonIgnore
    @OneToMany(mappedBy = "hoaDon", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<ChiTietHoaDon> chiTietHoaDons;

    @ManyToOne
    @JoinColumn(name = "maSoBan")
    private Ban ban;

    @Nationalized
    @Column(name = "ghiChu")
    private String ghiChu;

    @Column(name = "daTraHoaDon")
    private boolean daTraHoaDon;

    @Enumerated(EnumType.STRING)
    @Column(name = "tinhTrang")
    private TinhTrang tinhTrang;

    @Column(nullable = false, updatable = false, name = "ngayTao")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false, name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;

    public Double tongThanhTien(){
        AtomicReference<Double> tongTien = new AtomicReference<>((double) 0);
        this.chiTietHoaDons.forEach(x -> {
            tongTien.set(tongTien.get() + x.getThanhTien());
        });
        return tongTien.get();
    }
}
