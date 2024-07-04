import 'package:flutter/material.dart';
import 'package:noteblock/screens/create_note.dart';
import 'package:noteblock/screens/widgets/note_card.dart';

import '../models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteBlock"),
      ),

      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index){
            return NoteCard(note: notes[index], index: index, onNoteDeleted: onNoteDeleted, onNoteSaved: onNoteSaved,);
          },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateNote(onNewNoteCreated: onNewNoteCreated,)));
        },
        child: const Icon(Icons.add),
      ),

    );
  }

  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});
  }

  void onNoteDeleted(int index){
    notes.removeAt(index);
    setState(() {});
  }

  void onNoteSaved(Note note, int index){
    if (index >= 0 && index < notes.length) {
      // 2. Atualizar a nota na lista usando o índice
      setState(() {
        notes[index] = note;
      });
    }

  }
}
