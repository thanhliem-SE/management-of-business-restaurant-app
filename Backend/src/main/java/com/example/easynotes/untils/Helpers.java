package com.example.easynotes.untils;

import com.example.easynotes.model.*;
import com.example.easynotes.service.*;
import com.google.gson.Gson;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.FileReader;
import java.io.IOException;

@Component
public class Helpers {

    @Autowired
    NhaCungCapService nhaCungCapService;

    @Autowired
    TaiKhoanService taiKhoanService;

    @Autowired
    NhanVienService nhanVienService;

    @Autowired
    ThucPhamService thucPhamService;

    @Autowired
    ThanhToanService thanhToanService;

    @Autowired
    HoaDonService hoaDonService;

    @Autowired
    ChiTietThucPhamService chiTietThucPhamService;

    @Autowired
    ChiTietHoaDonService chiTietHoaDonService;

    @Autowired
    DanhMucService danhMucService;

    @Autowired
    BanService banService;
    public void initData() {
//        initNhaCungCap();
        initTaiKhoan();
        initNhanVien();
        initDanhMuc();
        initThucPham();
        // must put after thucpham
//        initThanhToan();
        initBan();
//        initHoaDon();
//        initChiTietHoaDon();
//        initChiTietThucPham();
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
    private void initThucPham() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/thuc_pham.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                ThucPham thucPham = new Gson().fromJson(jsonObject.toString(), ThucPham.class);

                thucPhamService.add(thucPham);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initThanhToan() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/thanh_toan.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                ThanhToan thanhToan = new Gson().fromJson(jsonObject.toString(), ThanhToan.class);
                thanhToanService.add(thanhToan);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initHoaDon() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/hoa_don.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                HoaDon hoaDon = new Gson().fromJson(jsonObject.toString(), HoaDon.class);
                hoaDonService.add(hoaDon);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }
    private void initChiTietHoaDon() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/chi_tiet_hoa_don.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                ChiTietHoaDon chiTietHoaDon = new Gson().fromJson(jsonObject.toString(), ChiTietHoaDon.class);
                chiTietHoaDonService.add(chiTietHoaDon);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initChiTietThucPham() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/chi_tiet_thuc_pham.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                ChiTietThucPham chiTietThucPham = new Gson().fromJson(jsonObject.toString(), ChiTietThucPham.class);
                chiTietThucPhamService.add(chiTietThucPham);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void initDanhMuc() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/danh_muc.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                DanhMuc danhMuc = new Gson().fromJson(jsonObject.toString(), DanhMuc.class);
                danhMucService.add(danhMuc);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }
    private void initBan() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/ban.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                Ban ban = new Gson().fromJson(jsonObject.toString(), Ban.class);
                banService.add(ban);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }
}
