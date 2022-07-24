part of 'change_password_cubit.dart';

extension ProfileStatusX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isSuccess => this == StateStatusEnum.success;

  bool get isFailure => this == StateStatusEnum.failure;
}

class ChangePasswordState {
  final StateStatusEnum changePasswordStatus;
  final String successMsg;
  final String errorMsg;

  ChangePasswordState({
    this.changePasswordStatus = StateStatusEnum.initial,
    this.successMsg = "",
    this.errorMsg = "",
  });

  ChangePasswordState copyWith({
    StateStatusEnum? changePasswordStatus,
    String? successMsg,
    String? errorMsg,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      successMsg: successMsg ?? this.successMsg,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
