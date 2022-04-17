import 'package:flutter/material.dart';

class ElevatedButtonRouded extends StatelessWidget {
  final BoxConstraints constraints;
  final String text;
  final VoidCallback? onPressed;
  const ElevatedButtonRouded({
    Key? key,
    required this.constraints,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepOrange),
              elevation: MaterialStateProperty.all<double>(3),
            ),
          ),
        ),
      ),
    );
  }
}
