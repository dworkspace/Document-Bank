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

class AddDocumentResponse {
  final String document;
  final int categoryId;
  final int id;

  AddDocumentResponse({
    required this.id,
    required this.categoryId,
    required this.document,
  });

  factory AddDocumentResponse.fromMap(Map<String, dynamic> map) {
    return AddDocumentResponse(
      id: map['id'],
      categoryId: map['category_id'],
      document: map['document'],
    );
  }
}

class DocumentResponse {
  final int id;
  final String photo;
  final String folder;
  final String createdDate;
  final String createdTime;

  DocumentResponse({
    required this.id,
    required this.photo,
    required this.folder,
    required this.createdDate,
    required this.createdTime,
  });

  factory DocumentResponse.fromMap(Map<String, dynamic> map) {
    return DocumentResponse(
      id: map["id"] ?? -1,
      photo: map['photo'] ?? '',
      folder: map["folder"] ?? "",
      createdDate: map['created_date'] ?? "",
      createdTime: map["created_time"] ?? "",
    );
  }
}
