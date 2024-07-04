import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NoteView extends StatefulWidget { // 1. Mudar para StatefulWidget
  const NoteView({
    super.key,
    required this.note,
    required this.index,
    required this.onNoteDeleted,
    required this.onNoteSaved, // Nova função para salvar
  });

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(Note, int) onNoteSaved; // Nova função para salvar

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  // 2. Controladores para os campos editáveis
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  // 3. Variável para controlar o modo de edição
  bool _editingMode = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingMode ? 'Editar Nota' : 'Sua Nota'),
        actions: [
          if (_editingMode) // 4. Botão Salvar visível apenas em modo de edição
            IconButton(
              onPressed: () {
                final updatedNote = Note(
                  title: _titleController.text,
                  content: _contentController.text,
                );
                widget.onNoteSaved(updatedNote, widget.index);
                setState(() => _editingMode = false); // Sair do modo de edição
              },
              icon: Icon(Icons.check),
            ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Tem certeza que deseja deletar essa nota ?"),
                    content: Text("A nota ${widget.note.title} será deletada!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onNoteDeleted(widget.index);
                          Navigator.of(context).pop();
                        },
                        child: const Text("DELETAR"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCELAR"),
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
          if (!_editingMode) // 6. Botão Editar visível apenas fora do modo de edição
            IconButton(
              onPressed: () {
                setState(() => _editingMode = true); // Entrar no modo de edição
              },
              icon: Icon(Icons.edit),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 7. Campos editáveis
            TextFormField(
              controller: _titleController,
              enabled: _editingMode, // Habilitar edição apenas no modo de edição
              style: TextStyle(fontSize: 25),
              decoration: const InputDecoration(
                border:  InputBorder.none, // Remover borda
                hintText: 'Título',
              ),
            ),
            SizedBox(height: 10),
            Expanded( // Expandir o TextField de conteúdo
              child: TextFormField(
                controller: _contentController,
                enabled: _editingMode, // Habilitar edição apenas no modo de edição
                style: TextStyle(fontSize: 18),
                maxLines: null, // Permitir múltiplas linhas
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Nota', // Remover borda
                  border:  InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
