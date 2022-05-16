import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/ban_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManageTableViewModel extends ChangeNotifier {
  List<int> _listRemoveTable = [];
  List<Ban> _listBan = [];
  bool _isInit = false;
  String _viTriBanThem = 'Tầng Trệt';
  int _soLuongBanThem = 0;

  getViTriBanThem() => _viTriBanThem;

  getSoLuongBanThem() => _soLuongBanThem;

  setViTriBanThem(String value) {
    _viTriBanThem = value;
    notifyListeners();
  }

  setSoLuongBanThem(int value) {
    _soLuongBanThem = value;
    notifyListeners();
  }

  getIsInit() => _isInit;

  getListBan() => _listBan;

  setListBan(List<Ban> listBan) {
    _listBan = listBan;
    notifyListeners();
  }

  addRemoveTable(int table) {
    _listRemoveTable.add(table);
    notifyListeners();
  }

  removeRemoveTable(int table) {
    _listRemoveTable.remove(table);
    notifyListeners();
  }

  List<int> getListRemoveTable() {
    return _listRemoveTable;
  }

  getListBanByViTri(String viTri) {
    return _listBan.where((element) => element.viTri == viTri).toList();
  }

  clear() {
    _listRemoveTable = [];
    _listBan = [];
    _isInit = false;
    _viTriBanThem = 'Tầng Trệt';
    _soLuongBanThem = 0;
  }

  init() async {
    _isInit = true;
    String token = await Helper.getToken();
    var response = await BanService().getListBan(token);
    if (response is Success) {
      setListBan(response.response as List<Ban>);
    }
  }

  addListBanBySoLuong(BuildContext context) async {
    String token = await Helper.getToken();
    var response =
        BanService().addListBanBySoLuong(token, _viTriBanThem, _soLuongBanThem);
    showAlertDialog(
        context: context,
        title: 'Thành công',
        message: 'Thêm $_soLuongBanThem bàn thành công');
    ThongBaoService().addThongBao(
        token,
        ThongBao(noiDung: "$_soLuongBanThem bàn được thêm tại $_viTriBanThem"),
        "PHUCVU");
    SocketViewModel.sendMessage("PHUCVU", "Thêm bàn",
        "$_soLuongBanThem bàn được thêm tại $_viTriBanThem");
    clear();
    init();
  }

  deleteBan(BuildContext context) async {
    String token = await Helper.getToken();

    for (int i = 0; i < _listRemoveTable.length; i++) {
      BanService().deleteBanById(token, _listRemoveTable[i]);
      if (i == _listRemoveTable.length - 1) {
        int soLuongBan = _listRemoveTable.length;
        showAlertDialog(
            context: context,
            title: 'Thành công',
            message: 'Xóa $soLuongBan bàn thành công');
        clear();
        init();
        ThongBaoService().addThongBao(
            token,
            ThongBao(noiDung: "$soLuongBan bàn không phục vụ được dọn đi"),
            "PHUCVU");
        SocketViewModel.sendMessage(
            "PHUCVU", "Xóa bàn", "$soLuongBan bàn không phục vụ được dọn đi");
      }
    }
  }

  updateBan(BuildContext context, Ban ban) async {
    String token = await Helper.getToken();
    var response = await BanService().updateBan(token, ban);
    Navigator.pop(context);
    showAlertDialog(
        context: context,
        title: 'Thành công',
        message: 'Cập nhật bàn thành công');
    ThongBaoService().addThongBao(
        token,
        ThongBao(noiDung: "Bàn ${ban.soBan} được cập nhật thông tin"),
        "PHUCVU");
    SocketViewModel.sendMessage(
        "PHUCVU", "Cập nhật bàn", "Bàn ${ban.soBan} được cập nhật thông tin");
    clear();
    init();
  }
}
