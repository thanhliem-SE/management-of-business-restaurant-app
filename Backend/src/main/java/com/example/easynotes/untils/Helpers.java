package com.example.easynotes.untils;

import com.example.easynotes.model.*;
import com.example.easynotes.repository.NhaCungCapRepository;
import com.example.easynotes.service.*;
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

    @Autowired
    ThucPhamService thucPhamService;

    @Autowired
    LieuLuongService lieuLuongService;

    @Autowired
    ThanhToanService thanhToanService;

    @Autowired
    BanService banService;

    @Autowired
    HoaDonService hoaDonService;

    @Autowired
    KhachHangService khachHangService;

    @Autowired
    ChiTietHoaDonService chiTietHoaDonService;
    public void initData() {
        initNhaCungCap();
        initNguyenLieu();
        initTaiKhoan();
        initNhanVien();
        initThucPham();
        // must put after thucpham and nguyen lieu
        initLieuLuong();
        initThanhToan();
        initBan();
        initKhachHang();
        initHoaDon();
        initChiTietHoaDon();
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

    private void initLieuLuong() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/lieu_luong.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                LieuLuong lieuLuong = new Gson().fromJson(jsonObject.toString(), LieuLuong.class);
                lieuLuong.setNguyenLieu(nguyenLieuService.getById(lieuLuong.getNguyenLieu().getMaNguyenLieu()));
                lieuLuong.setThucPham(thucPhamService.getById(lieuLuong.getThucPham().getMaThucPham()));
                lieuLuongService.add(lieuLuong);
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

    private void initKhachHang() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/khach_hang.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                KhachHang khachHang = new Gson().fromJson(jsonObject.toString(), KhachHang.class);
                khachHangService.add(khachHang);
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
}
