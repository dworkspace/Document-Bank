part of 'download_cubit.dart';

extension DownloadStatusX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isFailure => this == StateStatusEnum.failure;

  bool get isSuccess => this == StateStatusEnum.success;
}

class DownloadState {
  final StateStatusEnum status;

  DownloadState({this.status = StateStatusEnum.initial});

  DownloadState copyWith({
    StateStatusEnum? status,
  }) {
    return DownloadState(
      status: status ?? this.status,
    );
  }
}
