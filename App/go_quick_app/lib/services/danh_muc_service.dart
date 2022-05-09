import 'dart:convert';
import 'dart:io';

import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class DanhMucService {
  Future<Object> getDanhSachDanhMuc(String token) async {
    try {
      final response =
          await http.get(Uri.parse(api + 'danhmuc/'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: '$token'
      });

      if (response.statusCode == 200) {
        return Success(
            response: listDanhMucFromJson(utf8.decode(response.bodyBytes)));
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
