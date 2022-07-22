import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/app_prefs.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/model/account_setup.dart';
import 'package:document_bank/domain/usecase/account_setup_usecase.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  AccountSetupCubit(this._accountSetupUseCase, this._appPreferences)
      : super(AccountSetupState());

  void setImageFile(File file) {
    emit(state.copyWith(profileImageFile: file));
  }

  void accountSetup(AccountSetupRequest request) async {
    emit(state.copyWith(status: StateStatusEnum.loading));
    final response = await _accountSetupUseCase.execute(request);

    response.fold(
      (fail) => emit(state.copyWith(
          status: StateStatusEnum.failure, errorMsg: fail.message)),
      (data) {
        _appPreferences.saveUserStatus(data.status);
        emit(
          state.copyWith(status: StateStatusEnum.success, accountSetup: data),
        );
      },
    );
  }

  final AccountSetupUseCase _accountSetupUseCase;
  final AppPreferences _appPreferences;
}
