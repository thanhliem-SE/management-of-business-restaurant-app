package com.example.easynotes.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
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
public class HoaDon implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maHoaDon;

    @ManyToOne
    @JoinColumn(name = "maNhanVien")
    private NhanVien nguoiLapHoaDon;

    @OneToOne
    @JoinColumn(name = "maThanhToan")
    private ThanhToan thanhToan;

    @JsonIgnore
    @OneToMany(mappedBy = "hoaDon", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<ChiTietHoaDon> chiTietHoaDons;

    @ManyToOne
    @JoinColumn(name = "maSoBan")
    private Ban ban;

    @Enumerated(EnumType.STRING)
    private TinhTrang tinhTrang;

    @Column(nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false)
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
