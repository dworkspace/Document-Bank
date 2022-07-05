class AddDocumentsRequest {
  final String folderName;
  final List<String> paths;

  AddDocumentsRequest({
    required this.folderName,
    required this.paths,
  });
}
