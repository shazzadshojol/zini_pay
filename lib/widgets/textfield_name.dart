import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  final String text;

  const TextFieldName({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
}
