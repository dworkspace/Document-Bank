part of 'account_setup_cubit.dart';

extension StateStatusEnumX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isSuccess => this == StateStatusEnum.success;

  bool get isFailure => this == StateStatusEnum.failure;
}

class AccountSetupState {
  final File? profileImageFile;

  AccountSetupState({this.profileImageFile});

  AccountSetupState copyWith({
    File? profileImageFile,
  }) {
    return AccountSetupState(
      profileImageFile: profileImageFile ?? this.profileImageFile,
    );
  }
}
