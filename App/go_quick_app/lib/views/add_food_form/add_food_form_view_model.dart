import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/manage_food/manage_all_food_view.dart';

class AddFoodFormViewModel extends ChangeNotifier {
  bool intiialized = false;
  late List<DanhMuc> danhMucs = <DanhMuc>[];
  ThucPham thucPham = ThucPham();
  late List<String> urlHinhAnh = <String>[];
  List<String> get getUrlHinhAnh => this.urlHinhAnh;

  set setUrlHinhAnh(List<String> urlHinhAnh) => this.urlHinhAnh = urlHinhAnh;

  get getThucPham => this.thucPham;

  set setThucPham(thucPham) => this.thucPham = thucPham;
  List<DanhMuc> get getDanhMucs => this.danhMucs;

  set setDanhMucs(List<DanhMuc> danhMucs) => this.danhMucs = danhMucs;

  bool get getIntiialized => this.intiialized;

  set setIntiialized(bool intiialized) => this.intiialized = intiialized;

  Future<void> Init(BuildContext context) async {
    await loadingDanhMucs(context);
    setIntiialized = true;
    notifyListeners();
  }

  Future<void> loadingDanhMucs(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await DanhMucService().getDanhSachDanhMuc(token);
      if (response is Success) {
        danhMucs = response.response as List<DanhMuc>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> createThucPham(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await ThucPhamService().createThucPham(token, thucPham);
      if (response is Success) {
        clear();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thêm món ăn thành công")));
        NavigationHelper.pushReplacement(
            context: context, page: const ManageAllFoodView());
        ThongBaoService().addThongBao(
            token,
            ThongBao(
              noiDung:
                  "${thucPham.ten} được thêm vào danh sách thực phẩm cần duyệt",
            ),
            'CHEBIEN');
        SocketViewModel.sendMessage("QUANLY", "Thực phẩm mới cần duyệt",
            "${thucPham.ten} được thêm vào danh sách thực phẩm cần duyệt");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thêm món ăn")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  void clear() {
    danhMucs.clear();
    thucPham = ThucPham();
    urlHinhAnh.clear();
    intiialized = false;
  }
}
