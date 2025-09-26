import 'package:flutter/material.dart';
import '../ui/widgets/common/common.dart';
import '../ui/widgets/custom_button.dart';
import '../ui/widgets/custom_text_field.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add New Note"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextField(
              hint: "title",
              controller: _titleController,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                maxLines: 10,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: "Add Note",
              onTap: _addNewNote,
            )
          ],
        ),
      ),
    );
  }

  void _addNewNote() {
    showSnackBarMessage("New Node Added Successfully", context);
  }
}
