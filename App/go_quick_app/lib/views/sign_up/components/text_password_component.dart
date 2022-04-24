import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

class TextInputPassword extends StatefulWidget {
  final String hintPass;
  final ValueChanged<String> onChanged;
  const TextInputPassword({
    Key? key,
    required this.hintPass,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: _passwordVisible,
        enableSuggestions: false,
        autocorrect: false,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          label: Text(
            widget.hintPass,
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
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: Icon(_passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined),
          ),
        ),
      ),
    );
  }
}
