import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/usecase/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._changePasswordUseCase)
      : super(ChangePasswordState());

  void changePassword(ChangePasswordRequest request) async {
    emit(state.copyWith(changePasswordStatus: StateStatusEnum.loading));

    final response = await _changePasswordUseCase.execute(request);

    response.fold(
      (fail) => emit(state.copyWith(
          changePasswordStatus: StateStatusEnum.failure,
          errorMsg: fail.message)),
      (data) => emit(state.copyWith(
          changePasswordStatus: StateStatusEnum.success, successMsg: data)),
    );
  }

  final ChangePasswordUseCase _changePasswordUseCase;
}
