import 'package:flutter/material.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  String _tenMonTimKiem = '';
  String _ghiChu = '';
  bool _isInit = false;
  Map<int, int> _soLuongChonMon = {};
  List<ChiTietThucPham> _listChiTietThucPham = [];
  List<ChiTietHoaDon>? _listChiTietHoaDon = null;

  setGhiChu(String value) {
    _ghiChu = value;
    notifyListeners();
  }

  setListChiTietHoaDon(List<ChiTietHoaDon> value) {
    _listChiTietHoaDon = value;
  }

  getListChiTietHoaDon() {
    return _listChiTietHoaDon;
  }

  getGhiChu() {
    return _ghiChu;
  }

  get tenMonTimKiem => _tenMonTimKiem;

  setTenMonTimKiem(String value) {
    _tenMonTimKiem = value;
    notifyListeners();
  }

  getListThucPhamByTenMon() {
    List<ChiTietThucPham> listMonTimKiem = [];
    print(_tenMonTimKiem);
    if (_tenMonTimKiem.isNotEmpty) {
      return _listChiTietThucPham
          .where((element) =>
              element.thucPham!.ten!.toLowerCase().contains(_tenMonTimKiem))
          .toList();
    } else {
      return listMonTimKiem;
    }
  }

  getIsInit() => _isInit;

  getSoLuongChonMon(int maMon) {
    return _soLuongChonMon[maMon];
  }

  setSoLuongChonMon(int maChiTietThucPham, int soLuong) {
    _soLuongChonMon[maChiTietThucPham] = soLuong;
    notifyListeners();
  }

  setListChiTietThucPham(List<ChiTietThucPham> listChiTietThucPham) {
    _listChiTietThucPham = listChiTietThucPham;
    listChiTietThucPham.forEach((chiTietThucPham) {
      if (_soLuongChonMon[chiTietThucPham.maChiTietThucPham!] == null) {
        _soLuongChonMon[chiTietThucPham.maChiTietThucPham!] = 0;
      } else if (_soLuongChonMon[chiTietThucPham.maChiTietThucPham!]! >
          chiTietThucPham.soLuong!) {
        _soLuongChonMon[chiTietThucPham.maChiTietThucPham!] =
            chiTietThucPham.soLuong!;
      }
    });
    if (_listChiTietHoaDon != null) setDataEditOrder(_listChiTietHoaDon!);
    notifyListeners();
  }

  getListChiTietThucPham() {
    return _listChiTietThucPham;
  }

  getTotalPrice() {
    double totalPrice = 0;
    _listChiTietThucPham.forEach((element) {
      totalPrice += element.thucPham!.giaTien! *
          _soLuongChonMon[element.maChiTietThucPham]!;
    });
    return totalPrice;
  }

  init() {
    _isInit = true;
    getChiTietThucPhamFromServer();
  }

  getChiTietThucPhamFromServer({List<ChiTietHoaDon>? list}) async {
    String token = await Helper.getToken();
    var response =
        await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
    if (response is Success) {
      setListChiTietThucPham(response.response as List<ChiTietThucPham>);
    } else {
      return null;
    }
  }

  setDataEditOrder(List<ChiTietHoaDon> listChiTietHoaDon) async {
    String token = await Helper.getToken();
    listChiTietHoaDon.forEach((element) {
      _soLuongChonMon[element.thucPham!.maThucPham!] = element.soLuong!;
      ChiTietHoaDonService()
          .deleteChiTietHoaDon(token, element.maChiTietHoaDon!);
    });
    notifyListeners();
  }

  navigateToHoaDon({required Ban ban, required BuildContext context}) async {
    var response;

    String token = await Helper.getToken();
    NhanVien nguoiLapHoaDon = await Helper.getNhanVienSigned();

    HoaDon hoaDon = HoaDon(
        nguoiLapHoaDon: nguoiLapHoaDon,
        ban: ban,
        ghiChu: _ghiChu,
        tinhTrang: 'CHO');

    response = await HoaDonService().createHoaDon(token, hoaDon);

    if (response is Success) {
      HoaDon hoaDonCreated = response.response as HoaDon;
      for (int i = 0; i < _listChiTietThucPham.length; i++) {
        var element = _listChiTietThucPham[i];
        if (_soLuongChonMon[element.maChiTietThucPham!]! > 0) {
          await ChiTietHoaDonService().addChiTietHoaDon(
              token,
              ChiTietHoaDon(
                thucPham: element.thucPham,
                soLuong: _soLuongChonMon[element.maChiTietThucPham!],
                daCheBien: false,
                hoaDon: hoaDonCreated,
              ));
        }
        if (_listChiTietThucPham.length == i + 1) {
          Navigator.popUntil(context, (route) {
            return route.settings.name == 'RequestOrderView';
          });
          RequestOrderViewModel().init();
          NavigationHelper.push(
              context: context, page: BillView(hoaDon: hoaDonCreated));
          clear();

          NhanVien nhanVien = await Helper.getNhanVienSigned();
          ThongBaoService().addThongBao(
              token,
              ThongBao(
                noiDung:
                    "Có một yêu cầu đặt món mới (Bàn ${hoaDon.ban!.soBan})",
              ),
              'CHEBIEN');
          SocketViewModel.sendMessage(
            "CHEBIEN",
            "Yêu cầu đặt món mới",
          );
        }
      }
    }
  }

  addOrderToHoaDon(
      {required HoaDon hoaDon, required BuildContext context}) async {
    String token = await Helper.getToken();

    hoaDon.ghiChu = _ghiChu;
    hoaDon.tinhTrang = "CHO";
    await HoaDonService().updateHoaDon(token, hoaDon);

    for (int i = 0; i < _listChiTietThucPham.length; i++) {
      var element = _listChiTietThucPham[i];
      if (_soLuongChonMon[element.maChiTietThucPham!]! > 0) {
        await ChiTietHoaDonService().addChiTietHoaDon(
            token,
            ChiTietHoaDon(
              thucPham: element.thucPham,
              soLuong: _soLuongChonMon[element.maChiTietThucPham!],
              daCheBien: false,
              hoaDon: hoaDon,
            ));
      }
      if (_listChiTietThucPham.length == i + 1) {
        Navigator.popUntil(context, (route) {
          return route.settings.name == 'RequestOrderView';
        });
        RequestOrderViewModel().init();
        NavigationHelper.push(context: context, page: BillView(hoaDon: hoaDon));
        clear();

        NhanVien nhanVien = await Helper.getNhanVienSigned();
        ThongBaoService().addThongBao(
            token,
            ThongBao(
              noiDung: "Có một yêu cầu đặt món mới (Bàn ${hoaDon.ban!.soBan})",
            ),
            'CHEBIEN');
        SocketViewModel.sendMessage("CHEBIEN", "Yêu cầu đặt món mới");
      }
    }
  }

  clear() {
    _ghiChu = '';
    _tenMonTimKiem = '';
    _isInit = false;
    _soLuongChonMon = {};
    _listChiTietThucPham = [];
    _listChiTietHoaDon = null;
  }
}
