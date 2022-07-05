import 'package:document_bank/data/response/document_responses.dart';

class Document {
  final String document;
  final int id;
  final int categoryId;

  Document({
    required this.document,
    required this.categoryId,
    required this.id,
  });

  factory Document.fromDocumentResponse(DocumentResponse documentResponse) {
    return Document(
      document: documentResponse.document,
      categoryId: documentResponse.categoryId,
      id: documentResponse.id,
    );
  }
}
