class AddNoteRequest {
  final String title;
  final String content;
  final String folder;
  final int id; //this will only used while updating note

  AddNoteRequest({
    required this.content,
    required this.title,
    required this.folder,
    this.id = -1,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "folder": folder,
    };
  }
}
