import 'package:flutter/material.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/manage_food/manage_all_food_view.dart';

class FoodDetailViewModel extends ChangeNotifier {
  bool isInitialized = false;
  late ThucPham thucPham;
  ThucPham get getThucPham => this.thucPham;

  set setThucPham(ThucPham thucPham) => this.thucPham = thucPham;
  bool get getIsInitialized => this.isInitialized;

  set setIsInitialized(bool isInitialized) =>
      this.isInitialized = isInitialized;

  Future<void> xoaThucPham(BuildContext context, ThucPham thucPham) async {
    try {
      String token = await Helper.getToken();
      thucPham.isDeleted = true;
      var response = await ThucPhamService().updateThucPham(token, thucPham);
      if (response is Success) {
        NavigationHelper.pushReplacement(
          context: context,
          page: ManageAllFoodView(),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Xóa món ăn thành công")));
      } else {}
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
