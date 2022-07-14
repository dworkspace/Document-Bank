part of 'profile_cubit.dart';

extension ProfileStatusX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isSuccess => this == StateStatusEnum.success;

  bool get isFailure => this == StateStatusEnum.failure;
}

class ProfileState {
  final StateStatusEnum status;
  final Profile? profile;
  final String errorMsg;

  ProfileState({
    this.status = StateStatusEnum.initial,
    this.profile,
    this.errorMsg = "",
  });

  ProfileState copyWith({
    StateStatusEnum? status,
    Profile? profile,
    String? errorMsg,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
