import 'package:flutter/material.dart';

import '../widget/font_style.dart';
import '../widget/input_field.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key});
  final title = TextEditingController();
  final description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: iconColor,
          ),
        ),
        title: const Text(
          'Add note',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.save,
              color: iconColor,
              size: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputFieldWidget(
              hintText: 'Note title',
              controller: title,
            ),
            const SizedBox(height: 20),
            InputFieldWidget(
              hintText: 'Note description',
              controller: description,
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
