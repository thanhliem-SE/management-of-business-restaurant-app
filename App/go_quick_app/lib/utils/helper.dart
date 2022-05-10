import 'package:flutter/material.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static Future<bool> isHasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('token') != '') {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String token = prefs.getString('token')!;
      if (token != '') {
        return token;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static setNhanVienSigned(NhanVien nhanVien) async {
    var box = Hive.box('signed');
    box.put('nhanVien', nhanVien);
  }

  static Future<NhanVien> getNhanVienSigned() async {
    var box = Hive.box('signed');
    NhanVien nhanVien = box.get('nhanVien');
    return nhanVien;
  }

  static setTaiKhoanSigned(TaiKhoan taiKhoan) async {
    var box = Hive.box('signed');
    box.put('taiKhoan', taiKhoan);
  }

  static Future<TaiKhoan> getTaiKhoanSigned() async {
    var box = Hive.box('signed');
    TaiKhoan taiKhoan = box.get('taiKhoan');
    return taiKhoan;
  }

  static getTrangThaiHoaDon(String trangThai) {
    switch (trangThai) {
      case 'CHO':
        return 'Chờ xử lý';
      case 'DANGCHEBIEN':
        return 'Đang chế biến';
      case 'DACHEBIEN':
        return 'Đã chế biến';
      case 'CHUATHANHTOAN':
        return 'Chưa thanh toán';
      case 'DATHANHTOAN':
        return 'Đã thanh toán';
      case 'KHONGTIEPNHAN':
        return 'Không tiếp nhận';
      default:
        return 'Chưa xác định';
    }
  }

  static getNhanVien() {}
}
