import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/tai_khoan_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isInit = false;
  late TaiKhoan _taiKhoan;
  NhanVien _nhanVien = NhanVien();
  List<ThongBao> _listThongBao = [];

  getListThongBao() => _listThongBao;

  setListThongBao(List<ThongBao> listThongBao) {
    _listThongBao = listThongBao;
    notifyListeners();
  }

  get nhanVien => _nhanVien;

  setNhanVien(NhanVien nhanVien) async {
    _nhanVien = nhanVien;
    notifyListeners();
  }

  getIsInit() => _isInit;

  init() async {
    NhanVien nhanVien = await Helper.getNhanVienSigned();
    setNhanVien(nhanVien);

    String token = await Helper.getToken();
    final response = await ThongBaoService()
        .getThongBaoByTaiKhoan(token, nhanVien.taiKhoan ?? TaiKhoan());
    if (response is Success) {
      setListThongBao(response.response as List<ThongBao>);
    }

    _isInit = true;
  }

  checkThongBao() {
    bool rs = false;
    for (int i = 0; i < _listThongBao.length; i++) {
      if (_listThongBao[i].daXem == false) {
        rs = true;
        break;
      }
    }
    return rs;
  }

  getTaiKhoan(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await TaiKhoanService()
        .getTaiKhoanByToken(prefs.getString('token') ?? "");
    if (response is Success) {
      return response.response;
    }
    if (response is Failure) {
      String errorResponse = (response as Failure).errrorResponse as String;
    }
  }

  updateDaXemThongBao() async {
    String token = await Helper.getToken();
    for (int i = 0; i < _listThongBao.length; i++) {
      _listThongBao[i].daXem = true;
      await ThongBaoService().updateThongBao(token, _listThongBao[i]);
      if (i == _listThongBao.length - 1) {
        notifyListeners();
        init();
      }
    }
  }
}
