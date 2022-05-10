import 'package:flutter/material.dart';
import 'package:go_quick_app/components/text_field_container.dart';
import 'package:go_quick_app/config/palette.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? hintText;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText ?? "Nhập mật khẩu",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
