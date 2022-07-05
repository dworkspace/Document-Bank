import 'package:document_bank/data/response/document_responses.dart';

class Folder {
  final String title;
  final int id;

  Folder({
    required this.title,
    required this.id,
  });

  factory Folder.fromFolderResponse(FolderResponse folderResponse) {
    return Folder(title: folderResponse.title, id: folderResponse.id);
  }
}
