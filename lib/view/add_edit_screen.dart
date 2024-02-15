import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_storage/controller/note_controller.dart';
import 'package:local_storage/model/note_model.dart';
import 'package:local_storage/view/home_screen.dart';
import '../widget/font_style.dart';
import '../widget/input_field.dart';

class AddEditScreen extends StatefulWidget {
  AddEditScreen({super.key, this.noteModel});
  late NoteModel? noteModel;
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final title = TextEditingController();

  final description = TextEditingController();

  final time = DateTime.now();

  reloadData() {
    title.text = widget.noteModel!.title;
    description.text = widget.noteModel!.description;
  }

  @override
  void initState() {
    widget.noteModel == null ? '' : reloadData();
    super.initState();
  }

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
        title: Text(
          widget.noteModel == null ? 'Add note' : 'Edit note',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              widget.noteModel == null
                  ? await NoteController()
                      .insertData(
                        NoteModel(
                          id: Random().nextInt(1000),
                          title: title.text,
                          description: description.text,
                          time: '${time.year}-${time.month}-${time.day}',
                        ),
                      )
                      .whenComplete(() => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false))
                  : await NoteController()
                      .updateData(
                        NoteModel(
                          id: widget.noteModel!.id,
                          title: title.text,
                          description: description.text,
                          time: '${time.year}-${time.month}-${time.day}',
                        ),
                      )
                      .whenComplete(() => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false));
            },
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
