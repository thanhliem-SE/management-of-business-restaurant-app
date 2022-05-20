import 'dart:convert';
import 'dart:io';

import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class NhanVienService {
  Future<Object> getNhanVienByTenTaiKhoan(
      String token, String tenTaiKhoan) async {
    try {
      final response = await http.get(
          Uri.parse(api + 'nhanvien/getbytentaikhoan/$tenTaiKhoan'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: '$token'
          });

      if (response.statusCode == 200) {
        return Success(
            response:
                NhanVien.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errrorResponse: 'Thông tin đăng nhập không chính xác!');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errrorResponse: 'Không có kết nối internet!');
    } on FormatException {
      return Failure(
          code: INVALID_FORMAT, errrorResponse: 'Định dạng không hợp lệ!');
    } catch (e) {
      return Failure(code: UNKNOW_ERROR, errrorResponse: 'Lỗi không xác định!');
    }
  }

  Future<Object> getNhanVienTheoQuyen(String token, String quyen) async {
    try {
      final response = await http.get(
          Uri.parse(api + 'nhanvien/gettheoquyen/${quyen}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: '$token'
          });

      if (response.statusCode == 200) {
        return Success(
            response: listNhanVienFromJson(utf8.decode(response.bodyBytes)));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errrorResponse: 'Lỗi không xác định!');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errrorResponse: 'Không có kết nối internet!');
    } on FormatException {
      return Failure(
          code: INVALID_FORMAT, errrorResponse: 'Định dạng không hợp lệ!');
    } catch (e) {
      return Failure(code: UNKNOW_ERROR, errrorResponse: 'Lỗi không xác định!');
    }
  }

  Future<Object> updateNhanVien(String token, NhanVien nhanvien) async {
    try {
      final response = await http.put(
        Uri.parse(api + 'nhanvien/' + nhanvien.maNhanVien.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(nhanvien.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response:
                NhanVien.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errrorResponse: 'Lỗi không xác định!');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errrorResponse: 'Không có kết nối internet!');
    } on FormatException {
      return Failure(
          code: INVALID_FORMAT, errrorResponse: 'Định dạng không hợp lệ!');
    } catch (e) {
      return Failure(code: UNKNOW_ERROR, errrorResponse: 'Lỗi không xác định!');
    }
  }

  Future<Object> createNhanVien(String token, NhanVien nhanVien) async {
    try {
      final response = await http.post(
        Uri.parse(api + 'nhanvien/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(nhanVien.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response:
                NhanVien.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errrorResponse: 'Lỗi không xác định!');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errrorResponse: 'Không có kết nối internet!');
    } on FormatException {
      return Failure(
          code: INVALID_FORMAT, errrorResponse: 'Định dạng không hợp lệ!');
    } catch (e) {
      return Failure(code: UNKNOW_ERROR, errrorResponse: 'Lỗi không xác định!');
    }
  }
}
