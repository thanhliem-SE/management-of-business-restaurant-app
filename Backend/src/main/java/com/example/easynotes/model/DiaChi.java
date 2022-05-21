package com.example.easynotes.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;


@Embeddable
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaChi implements Serializable {
    @NotBlank
    @Column(name = "soNha")
    private String soNha;

    @NotBlank
    private String phuong;
    @NotBlank
    private String quan;
    @NotBlank
    private String tinh;
}
