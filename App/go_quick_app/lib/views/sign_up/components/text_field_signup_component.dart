import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

class TextFieldSignUp extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const TextFieldSignUp({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            label: Text(
              hintText,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            fillColor: Colors.deepOrange[50],
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.deepOrange,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            )),
      ),
    );
  }
}
