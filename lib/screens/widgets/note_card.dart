import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteblock/screens/note_view.dart';

import '../../models/note_model.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.index, required this.onNoteDeleted, required this.onNoteSaved});

  final Note note;
  final int index;

  final Function(int) onNoteDeleted;
  final Function(Note, int) onNoteSaved;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteView(note: note, index: index, onNoteDeleted: onNoteDeleted, onNoteSaved: onNoteSaved,)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                note.content,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0x66CCCCCC),

                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
