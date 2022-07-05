part of 'add_documents_bloc.dart';

enum AddDocumentsStatus { initial, loading, success, failure }

extension AddDocumentsStatusX on AddDocumentsStatus {
  bool get isLoading => this == AddDocumentsStatus.loading;

  bool get isSuccess => this == AddDocumentsStatus.success;

  bool get isFailure => this == AddDocumentsStatus.failure;
}

class AddDocumentsState {
  AddDocumentsState({
    this.pickedDocFiles = const [],
    this.isSelectFolder = true,
    this.status = AddDocumentsStatus.initial,
    this.documents = const [],
    this.errorMessage = "",
  });

  final AddDocumentsStatus status;
  final List<File> pickedDocFiles;
  final bool isSelectFolder;
  final List<Document> documents;
  final String errorMessage;

  AddDocumentsState copyWith({
    List<File>? pickedDocFiles,
    bool? isSelectFolder,
    AddDocumentsStatus? status,
    String? errorMsg,
    List<Document>? documents,
  }) {
    return AddDocumentsState(
      pickedDocFiles: pickedDocFiles ?? this.pickedDocFiles,
      isSelectFolder: isSelectFolder ?? true,
      status: status ?? AddDocumentsStatus.initial,
      errorMessage: errorMsg ?? errorMessage,
      documents: documents ?? this.documents,
    );
  }
}
