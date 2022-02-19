package com.example.easynotes.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.Nationalized;
import org.hibernate.validator.constraints.Range;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.bind.DefaultValue;
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
public class NguyenLieu  implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maNguyenLieu;

    @Nationalized
    @NotBlank
    private String tenNguyenLieu;

   @Range(min = 0)
   @Value("${some.key:0}")  //default value soLuong = 0
   private int soLuong;

   @NotBlank
   private String donViTinh;

   @Range(min = 0)
   private double giaTien;

    @Column(nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;

    @ManyToOne
    @JoinColumn(name = "maNhaCungCap", nullable = false)
    private NhaCungCap nhaCungCap;


    @OneToMany(mappedBy = "nguyenLieu", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<LieuLuong> lieuLuong;
}

