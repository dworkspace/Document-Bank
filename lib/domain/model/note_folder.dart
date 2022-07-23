import 'package:document_bank/data/response/note_responses.dart';

class NoteFolder {
  final int id;
  final String title;
  final String iconSvg;
  final int order;
  final int userId;

  NoteFolder({
    required this.userId,
    required this.order,
    required this.iconSvg,
    required this.title,
    required this.id,
  });

  factory NoteFolder.fromNoteFolderResponse(NoteFolderResponse response) {
    return NoteFolder(
      userId: response.userId,
      order: response.order,
      iconSvg: response.iconSvg,
      title: response.title,
      id: response.id,
    );
  }
}
