class AddNoteRequest {
  final String title;
  final String content;

  AddNoteRequest({
    required this.content,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
    };
  }
}
