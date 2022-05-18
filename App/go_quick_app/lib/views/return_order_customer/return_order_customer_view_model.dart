import 'package:flutter/material.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/ban_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';

class ReturnOrderCustomerViewModel extends ChangeNotifier {
  bool initialized = false;
  late List<HoaDon> listHoaDon;
  List<HoaDon> get getListHoaDon => this.listHoaDon;

  set setListHoaDon(List<HoaDon> listHoaDon) => this.listHoaDon = listHoaDon;

  bool get getInitialized => this.initialized;

  set setInitialized(bool initialized) => this.initialized = initialized;

  Future<void> intitializedAsync(BuildContext context) async {
    await loadHoaDonDaThanhToan(context);
    setInitialized = true;
    notifyListeners();
  }

  Future<void> loadHoaDonDaThanhToan(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await HoaDonService().getChuaTraHoaDon(token);
      if (response is Success) {
        setListHoaDon = response.response as List<HoaDon>;
      } else {
        setListHoaDon = <HoaDon>[];
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lấy danh sách hóa đơn thất bại")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  void clear() {
    listHoaDon.clear();
    setInitialized = false;
    notifyListeners();
  }

  Future<void> updateHoaDon(BuildContext context, HoaDon hoaDon) async {
    try {
      String token = await Helper.getToken();
      hoaDon.daTraHoaDon = true;
      var response = await HoaDonService().updateHoaDon(token, hoaDon);
      if (response is Success) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đã trả hóa đơn số ${hoaDon.maHoaDon}")));
        listHoaDon.remove(hoaDon);
        await updateBan(context, hoaDon);
        notifyListeners();
        ThongBaoService().addThongBao(
            token,
            ThongBao(
              noiDung:
                  "Hóa đơn tại bàn ${hoaDon.ban!.soBan} được trả về thành công",
            ),
            'PHUCVU');
        SocketViewModel.sendMessage("CHEBIEN", "Trả về hóa đơn thành công",
            "Hóa đơn tại bàn ${hoaDon.ban!.soBan} được trả về thành công");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Cập nhật hóa đơn thất bại")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> updateBan(BuildContext context, HoaDon hoaDon) async {
    try {
      String token = await Helper.getToken();
      if (hoaDon.ban != null) {
        Ban ban = hoaDon.ban!;
        ban.tinhTrang = null;
        var response = await BanService().updateBan(token, ban);
        if (response is Success) {
          ban = response.response as Ban;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bàn số ${ban.maSoBan} đã trống")));
          notifyListeners();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("cập nhật bàn thất bại")));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
