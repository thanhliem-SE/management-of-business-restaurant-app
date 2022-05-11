import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/components/text_field_container.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:provider/provider.dart';

import '../manage_table_view_model.dart';

class UpdateTableDialog extends StatelessWidget {
  final Ban ban;
  const UpdateTableDialog({
    Key? key,
    required this.ban,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageTableViewModel>(context);
    Size size = MediaQuery.of(context).size;
    int soBan = ban.soBan!;
    return AlertDialog(
      title: const Text(
        'CẬP NHẬT BÀN',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: size.height * 0.25,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vị trí'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số bàn'),
                Container(
                  color: Colors.blueGrey[50],
                  width: size.width * 0.25,
                  child: TextField(
                    onChanged: (value) {
                      soBan = soBan;
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: ban.soBan.toString(),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedButton(
                text: "Cập nhật",
                press: () {
                  ban.viTri = viewModel.getViTriBanThem();
                  ban.soBan = soBan;
                  viewModel.updateBan(context, ban);
                })
          ],
        ),
      ),
    );
  }
}
