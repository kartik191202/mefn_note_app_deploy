import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/note/note_cubit.dart';
import '../models/note_model.dart';
import 'widgets/common/common.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class AddNote extends StatefulWidget {
  final String uid;
  const AddNote({super.key, required this.uid});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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
        title: Text("New Note"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              hint: "title",
              controller: _titleController,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                maxLines: 10,
                controller: _descriptionController,
                decoration: InputDecoration(
                    hintText: "Description", border: InputBorder.none),
              ),
            ),
            SizedBox(
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
    if (_titleController.text.isEmpty) {
      showSnackBarMessage("Please Enter title", context);
      return;
    }
    if (_descriptionController.text.isEmpty) {
      showSnackBarMessage("Please Enter Description", context);
      return;
    }
    context
        .read<NoteCubit>()
        .addNote(NoteModel(
            title: _titleController.text,
            description: _descriptionController.text,
            creatorId: widget.uid))
        .then((value) {
      _clear();
    });
  }

  void _clear() {
    _titleController.clear();
    _descriptionController.clear();
    showSnackBarMessage("new note is added", context);
    setState(() {});
  }
}
