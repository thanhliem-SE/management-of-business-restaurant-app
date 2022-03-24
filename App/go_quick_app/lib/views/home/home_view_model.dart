import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/login_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  bool _loading = false;
  late TaiKhoan _taiKhoan;

  get loading => this._loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  getTaiKhoan(context) async {
    // setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await LoginService().getTaiKhoanByToken(prefs.getString('token')!);
    if (response is Success) {
      return response.response;
    }
    if (response is Failure) {
      String errorResponse = (response as Failure).errrorResponse as String;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorResponse)));
    }
  }
}
