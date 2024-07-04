import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova nota"),
        actions: [
          IconButton(
              onPressed: (){
                if(titleController.text.isEmpty){
                  return;
                }
                if(contentController.text.isEmpty){
                  return;
                }

                final note = Note(
                  content: contentController.text,
                  title: titleController.text,
                );

                widget.onNewNoteCreated(note);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.check))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 25
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Titulo",
                hintStyle: TextStyle(
                  color: Color(0x33CCCCCC),
                )
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
                child:TextFormField(
                  controller: contentController,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nota",
                      hintStyle: TextStyle(
                        color: Color(0x33CCCCCC),
                      )
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
