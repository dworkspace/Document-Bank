import 'package:document_bank/data/response/document_responses.dart';

class Document {
  final int id;
  final String photo;
  final String folder;
  final String createdDate;
  final String createdTime;

  Document({
    required this.id,
    required this.photo,
    required this.folder,
    required this.createdDate,
    required this.createdTime,
  });

  factory Document.fromDocumentResponse(DocumentResponse response) {
    return Document(
      id: response.id,
      photo: response.photo,
      folder: response.folder,
      createdDate: response.createdDate,
      createdTime: response.createdTime,
    );
  }
}
