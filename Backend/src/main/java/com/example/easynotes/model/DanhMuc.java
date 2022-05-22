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
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt"}, allowGetters = true)
@Entity
@Table(name = DanhMuc.TABLE_NAME)
public class DanhMuc implements Serializable {
    public static final String TABLE_NAME= "DanhMuc";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maDanhMuc;

    @Nationalized
    @NotBlank
    @Column(name = "loaiDanhMuc")
    private String loaiDanhMuc;

    @Column(name = "daXoa")
    private boolean isDeleted;

    @JsonIgnore
    @OneToMany(mappedBy = "danhMuc", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<ThucPham> thucPhams;

    @Column(nullable = false, updatable = false, name = "ngayTao")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false, name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;

}
