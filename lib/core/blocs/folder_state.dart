part of 'folder_cubit.dart';

enum FolderStatus { initial, loading, success, failure }

extension FolderStatusX on FolderStatus {
  bool get isLoading => this == FolderStatus.loading;

  bool get isFailure => this == FolderStatus.failure;

  bool get isSuccess => this == FolderStatus.success;
}

class FolderState {
  final FolderStatus status;
  final List<Folder> folders;
  final String errorMessage;

  FolderState({
    this.status = FolderStatus.initial,
    this.folders = const [],
    this.errorMessage = "",
  });

  FolderState copyWith({
    FolderStatus? status,
    List<Folder>? folders,
    String? errorMessage,
  }) {
    return FolderState(
      status: status ?? this.status,
      folders: folders ?? this.folders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
