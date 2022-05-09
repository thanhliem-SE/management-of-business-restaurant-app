import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:provider/provider.dart';

class AddNoteCancelDialog extends StatelessWidget {
  final HoaDon hoaDon;
  const AddNoteCancelDialog({Key? key, required this.hoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ResponseOrderViewModel>(context);
    return AlertDialog(
      title: const Text(
        'GHI CHÚ LÝ DO HỦY',
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
            ),
            RoundedButton(
                text: 'HỦY',
                press: () {
                  if (viewModel.getGhiChu() == '') {
                    showAlertDialog(
                        context: context,
                        title: 'Thất bại',
                        message: 'Vui lòng nhập lý do hủy yêu cầu đặt món');
                  } else {
                    hoaDon.ghiChu = viewModel.getGhiChu();
                    viewModel.setGhiChu('');
                    viewModel.updateTrangThaiHoaDon(hoaDon, 'KHONGTIEPNHAN');
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
    );
  }
}
