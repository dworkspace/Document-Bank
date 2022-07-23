class NoteResponse {
  final String title;
  final int id;
  final String content;
  final int folderId;

  NoteResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.folderId,
  });

  factory NoteResponse.fromMap(Map<String, dynamic> map) {
    return NoteResponse(
      id: map["id"] ?? -1,
      title: map["title"] ?? "",
      content: map["content"] ?? "",
      folderId: map["folder_id"] ?? -1,
    );
  }
}

class NoteFolderResponse {
  final int id;
  final String title;
  final String iconSvg;
  final int order;
  final int userId;

  NoteFolderResponse({
    required this.id,
    required this.title,
    required this.iconSvg,
    required this.order,
    required this.userId,
  });

  factory NoteFolderResponse.fromJson(Map<String, dynamic> json) {
    return NoteFolderResponse(
      id: json["id"] ?? -1,
      title: json['title'] ?? "",
      iconSvg: json['icon'] ?? "",
      order: json['order'] ?? -1,
      userId: json['user_id'] ?? -1,
    );
  }
}
