class FolderResponse {
  final String title;
  final int id;

  FolderResponse({
    required this.title,
    required this.id,
  });

  factory FolderResponse.fromMap(Map<String, dynamic> map) {
    return FolderResponse(
      title: map['title'] ?? "",
      id: map['id'] ?? 0,
    );
  }
}

class DocumentResponse {
  final String document;
  final int categoryId;
  final int id;

  DocumentResponse({
    required this.id,
    required this.categoryId,
    required this.document,
  });

  factory DocumentResponse.fromMap(Map<String, dynamic> map) {
    return DocumentResponse(
      id: map['id'],
      categoryId: map['category_id'],
      document: map['document'],
    );
  }
}
