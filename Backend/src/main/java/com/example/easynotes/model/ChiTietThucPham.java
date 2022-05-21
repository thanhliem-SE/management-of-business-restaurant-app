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
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt"}, allowGetters = true)
@Entity
@Table(name = ChiTietThucPham.TABLE_NAME)
public class ChiTietThucPham implements Serializable {
    public static final String TABLE_NAME= "ChiTietThucPham";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maChiTietThucPham;

    @ManyToOne
    @JoinColumn(name = "maThucPham")
    private ThucPham thucPham;

    @Min(value = 0)
    @Column(name = "soLuong")
    private int soLuong;

    @Column(name = "daXoa")
    private boolean isDeleted;

    @Column(nullable = false, updatable = false, name = "ngayTao")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false, name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;

    @Override
    public String toString() {
        return "ChiTietThucPham{" +
                "maChiTietThucPham=" + maChiTietThucPham +
                ", thucPham=" + thucPham +
                ", soLuong=" + soLuong +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
