import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  InputFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
  });
  var hintText;
  var controller = TextEditingController();
  var maxLines;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
      maxLines: maxLines,
    );
  }
}
