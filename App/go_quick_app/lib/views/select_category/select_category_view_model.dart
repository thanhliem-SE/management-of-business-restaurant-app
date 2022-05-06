import 'package:flutter/material.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/thanh_toan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/services/thanh_toan_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/request_order/request_order_view.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  double _totalPrice = 0;

  getTotalPrice() {
    // double sum = 0;
    // for (int i = 0; i < listAmoutFoodOrder.length; i++) {
    //   sum += listChiTietThucPham[i].thucPham.giaTien! * listAmoutFoodOrder[i];
    // }
    // return sum;
    return 100000;
  }
}

//   bool _isInit = false;
//   List<ChiTietThucPham> listChiTietThucPham = [];
//   List<int> listAmoutFoodOrder = [];


//   getAmoutFoodOrder(int index) {
//     return listAmoutFoodOrder[index];
//   }

//   setAmoutFoodOrder(int index, int value) {
//     listAmoutFoodOrder[index] = value;
//     notifyListeners();
//   }

//   getIsInit() {
//     return _isInit;
//   }

//   setListChiTietThucPham(List<ChiTietThucPham> value) {
//     listChiTietThucPham = value;
//     listAmoutFoodOrder = List.generate(listChiTietThucPham.length, (index) {
//       return 0;
//     });
//     notifyListeners();
//   }

//   getListChiTietThucPham() {
//     return listChiTietThucPham;
//   }

//   init() async {
//     String token = await Helper.getToken();
//     var response =
//         await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
//     if (response is Success) {
//       _isInit = true;
//       setListChiTietThucPham(response.response as List<ChiTietThucPham>);
//     } else {
//       return null;
//     }
//   }

//   navigateToHoaDon(
//       {required int soNguoi,
//       required int ban,
//       required BuildContext context}) async {
//     var response;

//     String token = await Helper.getToken();
//     NhanVien nguoiLapHoaDon = await Helper.getNhanVienSigned();

//     HoaDon hoaDon = HoaDon(
//         nguoiLapHoaDon: nguoiLapHoaDon,
//         tongThanhTien: _totalPrice,
//         ban: ban,
//         soNguoi: soNguoi,
//         tinhTrang: 'WAIT');

//     response = await HoaDonService().createHoaDon(token, hoaDon);
//     HoaDon hoaDonCreated = response.response as HoaDon;

//     for (int i = 0; i < listChiTietThucPham.length; i++) {
//       if (listAmoutFoodOrder[i] > 0) {
//         ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon(
//             thucPham: listChiTietThucPham[i].thucPham,
//             soLuong: listAmoutFoodOrder[i],
//             hoaDon: hoaDonCreated);
//         ChiTietHoaDonService().addChiTietHoaDon(token, chiTietHoaDon);
//       }
//     }

//     if (response is Success) {
//       SelectCategoryViewModel().init();

//       Navigator.popUntil(context, (route) {
//         return route.settings.name == 'RequestOrderView';
//       });

//       NavigationHelper.pushReplacement(
//           context: context, page: BillView(maHoaDon: hoaDonCreated.maHoaDon!));
//     }
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
// }
