package com.example.easynotes.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = {"createdAt", "updatedAt"}, allowGetters = true)
@Entity
@Table(name = TaiKhoan.TABLE_NAME)
public class TaiKhoan implements Serializable {
    public static final String TABLE_NAME= "TaiKhoan";

    @Id
    @Column(name = "tenTaiKhoan")
    private String tenTaiKhoan;

    @NotBlank
    @Column(name = "matKhau")
    private String matKhau;

    @Column(name = "daXoa")
    private boolean isDeleted;

    @Enumerated(EnumType.STRING)
    private Quyen quyen;

    @Column(nullable = false, updatable = false, name = "ngayTao")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(nullable = false, name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    private Date updatedAt;
}
