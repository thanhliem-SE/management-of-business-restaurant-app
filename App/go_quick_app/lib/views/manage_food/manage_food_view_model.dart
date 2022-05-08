import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManageFoodViewModel extends ChangeNotifier {
  bool _loading = false;
  List<DanhMuc>? danhmucs;
  bool get loading => this._loading;

  set loading(bool value) => this._loading = value;

  get getDanhmucs => this.danhmucs;

  void setDanhmucs(List<DanhMuc>? listDanhMuc) {
    this.danhmucs = danhmucs;
  }
}
