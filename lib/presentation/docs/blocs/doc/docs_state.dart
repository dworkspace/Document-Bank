part of 'docs_cubit.dart';

enum DocsStateEnum { initial, loading, success, failure }

extension DocsStateEnumX on DocsStateEnum {
  bool get isLoading => this == DocsStateEnum.loading;

  bool get isSuccess => this == DocsStateEnum.success;

  bool get isFailure => this == DocsStateEnum.failure;
}

class DocsState {
  final DocsStateEnum status;
  final List<Document> documents;
  final String errorMessage;
  final List<Folder> folders;

  DocsState({
    this.status = DocsStateEnum.initial,
    this.documents = const [],
    this.errorMessage = "",
    this.folders = const [],
  });

  DocsState copyWith({
    DocsStateEnum? status,
    String? errorMessage,
    List<Document>? documents,
    List<Folder>? folders,
  }) {
    return DocsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      documents: documents ?? this.documents,
      folders: folders ?? this.folders,
    );
  }
}
