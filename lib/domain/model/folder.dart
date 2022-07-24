import 'package:document_bank/data/response/document_responses.dart';
import 'package:document_bank/domain/model/document.dart';

class Folder {
  final String title;
  final int id;
  final List<Document> documents;

  Folder({
    required this.title,
    required this.id,
    this.documents = const [],
  });

  factory Folder.fromFolderResponse(FolderResponse folderResponse) {
    return Folder(
      title: folderResponse.title,
      id: folderResponse.id,
    );
  }

  Folder copyWith({
    String? title,
    int? id,
    List<Document>? documents,
  }) {
    return Folder(
      title: title ?? this.title,
      id: id ?? this.id,
      documents: documents ?? this.documents,
    );
  }
}
