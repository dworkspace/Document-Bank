import 'package:document_bank/data/response/document_responses.dart';

class AddDocument {
  final String document;
  final int id;
  final int categoryId;

  AddDocument({
    required this.document,
    required this.categoryId,
    required this.id,
  });

  factory AddDocument.fromAddDocumentResponse(
      AddDocumentResponse documentResponse) {
    return AddDocument(
      document: documentResponse.document,
      categoryId: documentResponse.categoryId,
      id: documentResponse.id,
    );
  }
}
