class NoteResponse {
  final String title;
  final int id;
  final String content;

  NoteResponse({
    required this.id,
    required this.title,
    required this.content,
  });

  factory NoteResponse.fromMap(Map<String, dynamic> map) {
    return NoteResponse(
      id: map["id"] ?? -1,
      title: map["title"] ?? "",
      content: map["content"] ?? "",
    );
  }
}
