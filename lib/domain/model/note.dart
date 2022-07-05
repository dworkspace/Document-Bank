import 'package:document_bank/data/response/note_responses.dart';

class Note {
  final String title;
  final int id;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Note.fromNoteResponse(NoteResponse response) {
    return Note(
      id: response.id,
      title: response.title,
      content: response.content,
    );
  }
}
