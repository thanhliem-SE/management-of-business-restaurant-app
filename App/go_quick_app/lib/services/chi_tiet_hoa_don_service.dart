import 'dart:convert';
import 'dart:io';

import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ChiTietHoaDonService {
  Future<Object> getChiTietHoaDonByMaHoaDon(String token, int maHoaDon) async {
    try {
      final response = await http.get(
          Uri.parse(api + 'chitiethoadon/danhsachtheohoadon/$maHoaDon'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: '$token'
          });

      if (response.statusCode == 200) {
        return Success(response: listChiTietHoaDonFromJson(response.body));
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

  Future<Object> addChiTietHoaDon(
      String token, ChiTietHoaDon chiTietHoaDon) async {
    try {
      final response = await http.post(
        Uri.parse(api + 'chitiethoadon/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: '$token'
        },
        body: json.encode(chiTietHoaDon.toJson()),
      );

      if (response.statusCode == 200) {
        return Success(
            response: ChiTietHoaDon.fromJson(jsonDecode(response.body)));
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
