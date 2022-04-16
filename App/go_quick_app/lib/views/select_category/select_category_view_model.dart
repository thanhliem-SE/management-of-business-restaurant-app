import 'package:flutter/material.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/khach_hang.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/thanh_toan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/services/khach_hang_service.dart';
import 'package:go_quick_app/services/thanh_toan_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<ChiTietThucPham> listChiTietThucPham = [];
  List<int> listAmoutFoodOrder = [];
  double _totalPrice = 0;

  getToTalPrice() {
    double sum = 0;
    for (int i = 0; i < listAmoutFoodOrder.length; i++) {
      sum += listChiTietThucPham[i].thucPham.giaTien * listAmoutFoodOrder[i];
    }
    return sum;
  }

  getAmoutFoodOrder(int index) {
    return listAmoutFoodOrder[index];
  }

  setAmoutFoodOrder(int index, int value) {
    listAmoutFoodOrder[index] = value;
    notifyListeners();
  }

  getIsInit() {
    return _isInit;
  }

  setListChiTietThucPham(List<ChiTietThucPham> value) {
    listChiTietThucPham = value;
    listAmoutFoodOrder = List.generate(listChiTietThucPham.length, (index) {
      return 0;
    });
    notifyListeners();
  }

  getListChiTietThucPham() {
    return listChiTietThucPham;
  }

  init() async {
    String token = await Helper.getToken();
    var response =
        await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
    if (response is Success) {
      _isInit = true;
      setListChiTietThucPham(response.response as List<ChiTietThucPham>);
    } else {
      return null;
    }
  }

  navigateToHoaDon(
      {required int soNguoi,
      required int ban,
      required BuildContext context}) async {
    var response;

    String token = await Helper.getToken();
    NhanVien nguoiLapHoaDon = await Helper.getNhanVienSigned();
    KhachHang? khachHang = null;
    ThanhToan? thanhToan = null;

    response = await KhachHangService().getKhachHangByMaKhachHang(token, 1);
    if (response is Success) {
      khachHang = response.response as KhachHang;
    }

    response = await ThanhToanService().getThanhToanByMaThanhToan(token, 1);
    if (response is Success) {
      thanhToan = response.response as ThanhToan;
    }

    HoaDon hoaDon = HoaDon(
        nguoiLapHoaDon: nguoiLapHoaDon,
        khachHang: khachHang!,
        tongThanhTien: _totalPrice,
        thanhToan: thanhToan!,
        ban: ban,
        soNguoi: soNguoi,
        tinhTrang: 'WAIT');

    response = await HoaDonService().createHoaDon(token, hoaDon);
    if (response is Success) {
      NavigationHelper.pushReplacement(
          context: context,
          page: BillView(
            hoaDon: response.response as HoaDon,
          ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
