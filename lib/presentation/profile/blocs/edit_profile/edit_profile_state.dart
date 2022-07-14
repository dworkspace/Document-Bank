part of 'edit_profile_cubit.dart';

extension EditProfileStateX on StateStatusEnum {
  bool get isUpdating => this == StateStatusEnum.loading;

  bool get isUpdated => this == StateStatusEnum.success;

  bool get isFailed => this == StateStatusEnum.failure;
}

class EditProfileState {
  final StateStatusEnum editStatus;
  final File? pickedPhotoFile;
  final String editErrorMsg;
  final Profile? profile;

  EditProfileState({
    this.pickedPhotoFile,
    this.editStatus = StateStatusEnum.initial,
    this.editErrorMsg = "",
    this.profile,
  });

  EditProfileState copyWith({
    File? pickedPhotoFile,
    StateStatusEnum? editStatus,
    String? editErrorMsg,
    Profile? profile,
  }) {
    return EditProfileState(
      pickedPhotoFile: pickedPhotoFile ?? this.pickedPhotoFile,
      editStatus: editStatus ?? this.editStatus,
      editErrorMsg: editErrorMsg ?? this.editErrorMsg,
      profile: profile ?? this.profile,
    );
  }
}
