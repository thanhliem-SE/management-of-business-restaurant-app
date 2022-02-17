package com.example.easynotes.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaChi {
    private String msoNha;
    private String phuong;
    private String quan;
    private String tinh;
}
