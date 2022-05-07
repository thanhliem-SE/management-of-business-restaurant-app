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
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:provider/provider.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<SelectCategoryViewModel>(context);
    return AlertDialog(
      title: const Text(
        'GHI CHÚ',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RoundedInputField(
              hintText: 'Thêm ghi chú',
              onChanged: (value) {
                viewModel.setGhiChu(value);
              },
              icon: Icons.fastfood_outlined,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(viewModel.getGhiChu()),
            )
          ],
        ),
      ),
    );
  }
}
