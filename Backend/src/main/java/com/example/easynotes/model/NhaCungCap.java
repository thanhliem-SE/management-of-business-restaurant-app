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
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt", "dsNguyenLieu"}, allowGetters = true)
@Entity
@Table(name = NhaCungCap.TABLE_NAME)
public class NhaCungCap implements Serializable {
    public static final String TABLE_NAME= "NhaCungCap";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maNhaCungCap;

    @Nationalized
    @NotBlank
    @Column(name = "tenNhaCungCap")
    private String tenNhaCungCap;

    @Column(name = "daXoa")
    private boolean isDeleted;

    @Nationalized
    @Lob   // mapping to Text Type on MySQL
    @NotBlank
    @Column(name = "moTa")
    private String moTa;

    @Embedded
    private DiaChi diaChi;

    @Column(nullable = false, updatable = false, name = "ngayTao")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false, name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;
//
//    @JsonIgnore
//    @OneToMany(mappedBy = "nhaCungCap", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//    private List<NguyenLieu> dsNguyenLieu;

}
