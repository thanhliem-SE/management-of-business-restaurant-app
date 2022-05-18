import 'dart:convert';
import 'dart:io';

import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class HoaDonService {
  Future<Object> getHoaDonChuaThanhToan(String token) async {
    try {
      final response = await http.get(Uri.parse(api + 'hoadon/chuathanhtoan'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: '$token'
          });

      if (response.statusCode == 200) {
        return Success(
            response: listHoaDonFromJson(utf8.decode(response.bodyBytes)));
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

  Future<Object> getHoaDonPhucVuTaiBan(String token, int maSoBan) async {
    try {
      final response = await http.get(
          Uri.parse(api + 'hoadon/phucvutaiban/$maSoBan'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: '$token'
          });

      if (response.statusCode == 200) {
        return Success(
            response:
                HoaDon.fromJson(json.decode(utf8.decode(response.bodyBytes))));
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

  Future<Object> getHoaDonByMaHoaDon(String token, int maHoaDon) async {
    try {
      final response = await http
          .get(Uri.parse(api + 'hoadon/$maHoaDon'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: '$token'
      });

      if (response.statusCode == 200) {
        return Success(
            response:
                HoaDon.fromJson(json.decode(utf8.decode(response.bodyBytes))));
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

  Future<Object> createHoaDon(String token, HoaDon hoaDon) async {
    try {
      final response = await http.post(
        Uri.parse(api + 'hoadon/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(hoaDon.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response:
                HoaDon.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
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

  Future<Object> updateHoaDon(String token, HoaDon hoaDon) async {
    try {
      final response = await http.put(
        Uri.parse(api + 'hoadon/' + hoaDon.maHoaDon.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(hoaDon.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response:
                HoaDon.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
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

  Future<Object> getDanhSachHoaDon(String token) async {
    try {
      final response =
          await http.get(Uri.parse(api + 'hoadon/'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: '$token'
      });

      if (response.statusCode == 200) {
        return Success(
            response: listHoaDonFromJson(utf8.decode(response.bodyBytes)));
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

  Future<Object> getChuaTraHoaDon(String token) async {
    try {
      final response = await http.get(Uri.parse(api + 'hoadon/chuatrahoadon'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: '$token'
          });

      if (response.statusCode == 200) {
        return Success(
            response: listHoaDonFromJson(utf8.decode(response.bodyBytes)));
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
