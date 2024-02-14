import 'package:flutter/material.dart';
import 'package:local_storage/controller/note_controller.dart';
import 'package:local_storage/model/note_model.dart';
import 'package:local_storage/view/add_edit_screen.dart';
import '../widget/card_item.dart';
import '../widget/font_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<NoteModel>>? list;
  late NoteController controller;
  onRefresh() {
    controller = NoteController();
    setState(() {
      list = controller.getData();
    });
  }

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text(
          'Dating note',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: iconColor,
              size: 28,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(Icons.error),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => CardItem(
                model: snapshot.data![index],
              ),
            );
          }
        },
      ),
    );
  }
}
