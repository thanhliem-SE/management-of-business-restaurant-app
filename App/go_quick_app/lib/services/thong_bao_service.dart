import 'dart:convert';
import 'dart:io';

import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ThongBaoService {
  Future<Object> getThongBaoByTaiKhoan(String token, TaiKhoan taiKhoan) async {
    try {
      final response = await http.post(
        Uri.parse(api + 'thongbao/getbytaikhoan'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(taiKhoan.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response: listThongBaoFromJson(utf8.decode(response.bodyBytes)));
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

  Future<Object> updateThongBao(String token, ThongBao thongBao) async {
    try {
      final response = await http.put(
        Uri.parse(api + 'thongbao/' + thongBao.maThongBao.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(thongBao.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response: ThongBao.fromJson(
                json.decode(utf8.decode(response.bodyBytes))));
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

  Future<Object> addThongBao(
      String token, ThongBao thongBao, String quyen) async {
    try {
      final response = await http.post(
        Uri.parse(api + 'thongbao/$quyen'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(thongBao.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response: ThongBao.fromJson(
                json.decode(utf8.decode(response.bodyBytes))));
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
