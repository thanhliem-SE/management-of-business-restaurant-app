import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/components/text_field_container.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/services/ban_service.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:provider/provider.dart';

class AddTableDialog extends StatelessWidget {
  const AddTableDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageTableViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        'THÊM BÀN',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  items: <String>['Tầng Trệt', 'Tầng 1']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    viewModel.setViTriBanThem(value.toString());
                  },
                  value: viewModel.getViTriBanThem(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.002,
            ),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  viewModel.setSoLuongBanThem(int.parse(value));
                },
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.chair,
                    color: kPrimaryColor,
                  ),
                  hintText: 'Nhập số lượng bàn',
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedButton(
                text: 'Xác nhận',
                press: () {
                  if (viewModel.getSoLuongBanThem() <= 0) {
                    showAlertDialog(
                        context: context,
                        title: 'Thất bại',
                        message: 'Số lượng bàn phải lớn hơn 0');
                  } else {
                    viewModel.addListBanBySoLuong(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
