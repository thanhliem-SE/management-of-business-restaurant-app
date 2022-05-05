import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/components/text_field_container.dart';
import 'package:go_quick_app/config/palette.dart';

class AddTableDialog extends StatelessWidget {
  const AddTableDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'THÊM BÀN',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {},
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
            RoundedButton(text: 'Xác nhận', press: () {}),
          ],
        ),
      ),
    );
  }
}
