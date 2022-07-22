part of 'account_setup_cubit.dart';

extension StateStatusEnumX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isSuccess => this == StateStatusEnum.success;

  bool get isFailure => this == StateStatusEnum.failure;
}

class AccountSetupState {
  final File? profileImageFile;
  final StateStatusEnum status;
  final AccountSetup? accountSetup;
  final String errorMsg;

  AccountSetupState({
    this.profileImageFile,
    this.status = StateStatusEnum.initial,
    this.accountSetup,
    this.errorMsg = "",
  });

  AccountSetupState copyWith({
    File? profileImageFile,
    StateStatusEnum? status,
    AccountSetup? accountSetup,
    String? errorMsg,
  }) {
    return AccountSetupState(
      profileImageFile: profileImageFile ?? this.profileImageFile,
      status: status ?? this.status,
      accountSetup: accountSetup ?? this.accountSetup,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
