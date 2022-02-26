package com.example.easynotes.untils;

import com.example.easynotes.model.NguyenLieu;
import com.example.easynotes.model.NhaCungCap;
import com.example.easynotes.model.NhanVien;
import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.repository.NhaCungCapRepository;
import com.example.easynotes.service.NguyenLieuService;
import com.example.easynotes.service.NhaCungCapService;
import com.example.easynotes.service.NhanVienService;
import com.example.easynotes.service.TaiKhoanService;
import com.google.gson.Gson;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.io.FileReader;
import java.io.IOException;

@Component
public class Helpers {

    @Autowired
    NhaCungCapService nhaCungCapService;

    @Autowired
    NguyenLieuService nguyenLieuService;

    @Autowired
    TaiKhoanService taiKhoanService;

    @Autowired
    NhanVienService nhanVienService;

    public void initData() {
        initNhaCungCap();
        initNguyenLieu();
        initTaiKhoan();
        initNhanVien();
    }

    private void initNhaCungCap() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/nha_cung_cap.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                NhaCungCap nhaCungCap = new Gson().fromJson(jsonObject.toString(), NhaCungCap.class);
                nhaCungCapService.add(nhaCungCap);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initNguyenLieu() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/nguyen_lieu.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                NguyenLieu nguyenLieu = new Gson().fromJson(jsonObject.toString(), NguyenLieu.class);

                // Because nhaCungCap in nguyen_lieu.json only properties maNhaCungCap
                NhaCungCap nhaCungCap = nhaCungCapService.getById(nguyenLieu.getNhaCungCap().getMaNhaCungCap());
                nguyenLieu.setNhaCungCap(nhaCungCap);

                nguyenLieuService.add(nguyenLieu);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initTaiKhoan() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/tai_khoan.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                TaiKhoan taiKhoan = new Gson().fromJson(jsonObject.toString(), TaiKhoan.class);
                taiKhoanService.add(taiKhoan);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initNhanVien() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/nhan_vien.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                NhanVien nhanVien = new Gson().fromJson(jsonObject.toString(), NhanVien.class);

                TaiKhoan taiKhoan = taiKhoanService.getByTenTaiKhoan(nhanVien.getTaiKhoan().getTenTaiKhoan());
                nhanVien.setTaiKhoan(taiKhoan);

                nhanVienService.add(nhanVien);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

}
