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
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt"}, allowGetters = true)
@Entity
@Table(name = ThucPham.TABLE_NAME)
public class ThucPham implements Serializable {
    public static final String TABLE_NAME= "ThucPham";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maThucPham")
    private Long maThucPham;

    @Nationalized
    @NotBlank
    private String ten;

    @Nationalized
    @Lob
    @NotBlank
    @Column(name = "moTa")
    private String moTa;

    @Column(name = "daXoa")
    private boolean isDeleted;

    @Column(name = "giaTien")
    @Min(value = 0)
    private double giaTien;

    @Lob
    @ElementCollection
    private List<String> urlHinhAnh;

    @Nationalized
    @Lob
    @Column(name = "chiTiet")
    private String chiTiet;

    @Nationalized
    @NotBlank
    @Column(name = "trangThai")
    private String trangThai;

    @ManyToOne
    @JoinColumn(name = "maNhaCungCap")
    private NhaCungCap nhaCungCap;

    @ManyToOne
    @JoinColumn(name = "maDanhMuc")
    private DanhMuc danhMuc;

    @Column(nullable = false, updatable = false, name = "ngayTao")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false, name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;







}
