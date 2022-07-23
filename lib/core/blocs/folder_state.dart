part of 'folder_cubit.dart';

enum FolderStatus { initial, loading, success, failure }

extension FolderStatusX on FolderStatus {
  bool get isLoading => this == FolderStatus.loading;

  bool get isFailure => this == FolderStatus.failure;

  bool get isSuccess => this == FolderStatus.success;
}

class FolderState {
  final FolderStatus status;
  final FolderStatus noteFolderStatus;
  final List<Folder> folders;
  final List<NoteFolder> noteFolders;
  final String errorMessage;

  FolderState({
    this.status = FolderStatus.initial,
    this.noteFolderStatus = FolderStatus.initial,
    this.folders = const [],
    this.errorMessage = "",
    this.noteFolders = const [],
  });

  FolderState copyWith({
    FolderStatus? status,
    FolderStatus? noteFolderStatus,
    List<Folder>? folders,
    List<NoteFolder>? noteFolders,
    String? errorMessage,
  }) {
    return FolderState(
      status: status ?? this.status,
      noteFolderStatus: noteFolderStatus ?? this.noteFolderStatus,
      folders: folders ?? this.folders,
      noteFolders: noteFolders ?? this.noteFolders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
