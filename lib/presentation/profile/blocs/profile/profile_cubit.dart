import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/domain/usecase/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfileUseCase) : super(ProfileState()) {
    getProfile();
  }

  void getProfile() async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    final response = await _getProfileUseCase.execute(Void);

    response.fold(
      (fail) => emit(state.copyWith(
          status: StateStatusEnum.failure, errorMsg: fail.message)),
      (data) => emit(state.copyWith(
        status: StateStatusEnum.success,
        profile: data,
      )),
    );
  }

  final GetProfileUseCase _getProfileUseCase;
}
