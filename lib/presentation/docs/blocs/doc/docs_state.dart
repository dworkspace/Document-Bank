part of 'docs_cubit.dart';

enum DocsStateEnum { initial, loading, success, failure }

extension DocsStateEnumX on DocsStateEnum {
  bool get isLoading => this == DocsStateEnum.loading;

  bool get isSuccess => this == DocsStateEnum.success;

  bool get isFailure => this == DocsStateEnum.failure;
}

class DocsState {
  final DocsStateEnum status;
  final DocsStateEnum deleteStatus;
  final List<Document> documents;
  final String errorMessage;
  final String deleteErrorMsg;
  final List<Folder> folders;
  final List<SelectableDocument> docs;
  final bool isSelectEnabled;

  DocsState({
    this.status = DocsStateEnum.initial,
    this.documents = const [],
    this.errorMessage = "",
    this.folders = const [],
    this.docs = const [],
    this.isSelectEnabled = false,
    this.deleteStatus = DocsStateEnum.initial,
    this.deleteErrorMsg = "",
  });

  DocsState copyWith({
    DocsStateEnum? status,
    DocsStateEnum? deleteStatus,
    String? errorMessage,
    String? deleteErrorMsg,
    List<Document>? documents,
    List<Folder>? folders,
    List<SelectableDocument>? docs,
    bool? isSelectEnabled,
  }) {
    return DocsState(
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? DocsStateEnum.initial,
      errorMessage: errorMessage ?? this.errorMessage,
      documents: documents ?? this.documents,
      folders: folders ?? this.folders,
      docs: docs ?? this.docs,
      isSelectEnabled: isSelectEnabled ?? this.isSelectEnabled,
      deleteErrorMsg: deleteErrorMsg ?? this.deleteErrorMsg,
    );
  }
}
