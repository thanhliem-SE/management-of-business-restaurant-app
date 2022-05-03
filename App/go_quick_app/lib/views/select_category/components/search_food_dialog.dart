import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/components/list_view_food.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class SearchFoodDialog extends StatelessWidget {
  const SearchFoodDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<RequestOrderViewModel>(context);
    List<ChiTietThucPham> listChiTietThucPham = [
      ChiTietThucPham(
          maChiTietThucPham: 1,
          thucPham: ThucPham(
              maThucPham: 1,
              ten: 'Cơm tấm',
              giaTien: 30000,
              urlHinhAnh: [
                'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg'
              ]),
          soLuong: 5),
    ];
    return AlertDialog(
      title: const Text(
        'TÌM KIẾM MÓN ĂN',
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          RoundedInputField(
            hintText: 'Nhập tên món',
            onChanged: (value) {},
            icon: Icons.fastfood_outlined,
          ),
          SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: ListViewFood(
              listChiTietThucPham: listChiTietThucPham,
              isDialog: true,
            ),
          )
        ],
      ),
    );
  }
}
