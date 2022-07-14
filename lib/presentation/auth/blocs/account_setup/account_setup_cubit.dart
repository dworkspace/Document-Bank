import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  AccountSetupCubit() : super(AccountSetupState());

  void setImageFile(File file) {
    emit(state.copyWith(profileImageFile: file));
  }
}
