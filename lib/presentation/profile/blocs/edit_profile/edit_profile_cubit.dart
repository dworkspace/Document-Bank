import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/domain/usecase/update_profile_usecase.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._updateProfileUseCase) : super(EditProfileState());

  void setImageFile(File file) {
    emit(state.copyWith(pickedPhotoFile: file));
  }

  void updateProfile(UpdateProfileRequest updateProfileRequest) async {
    emit(state.copyWith(editStatus: StateStatusEnum.loading));

    final response = await _updateProfileUseCase.execute(updateProfileRequest);

    response.fold(
      (fail) => emit(state.copyWith(
          editStatus: StateStatusEnum.failure, editErrorMsg: fail.message)),
      (data) => emit(state.copyWith(
        editStatus: StateStatusEnum.success,
        profile: data,
      )),
    );
  }

  final UpdateProfileUseCase _updateProfileUseCase;
}
