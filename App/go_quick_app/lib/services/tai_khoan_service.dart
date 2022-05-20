import 'dart:convert';
import 'dart:io';

import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class TaiKhoanService {
  Future<Object> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse(api + 'login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'username': username, 'password': password}));

      if (response.statusCode == 200) {
        return Success(response: response.body);
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

  Future<Object> getTaiKhoanByToken(String token) async {
    try {
      final response = await http.post(Uri.parse(api + 'getbytoken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'token': token}));

      if (response.statusCode == 200) {
        return Success(
            response:
                TaiKhoan.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
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

  Future<Object> doiMatKhau(String token, String tenTaiKhoan, String matKhauCu,
      String matKhauMoi) async {
    try {
      final response = await http.get(
        Uri.parse(api + 'taikhoan/$tenTaiKhoan/$matKhauCu/$matKhauMoi'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
      );

      if (response.statusCode == 200) {
        return Success(
            response:
                TaiKhoan.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
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
}
