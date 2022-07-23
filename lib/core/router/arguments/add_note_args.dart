import 'package:document_bank/domain/model/note_folder.dart';

class AddNoteArg {
  String title;
  String description;
  int id;
  NoteFolder noteFolder;

  AddNoteArg({
    required this.title,
    required this.description,
    required this.id,
    required this.noteFolder,
  });
}
