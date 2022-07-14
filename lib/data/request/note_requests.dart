class AddNoteRequest {
  final String title;
  final String content;
  final int id; //this will only used while updating note

  AddNoteRequest({
    required this.content,
    required this.title,
    this.id = -1,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
    };
  }
}
