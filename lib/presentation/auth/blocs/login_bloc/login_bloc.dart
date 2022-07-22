import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/app_prefs.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/domain/usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/request/auth_requests.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase, this._appPreferences) : super(LoginInitial()) {
    on<PerformLoginEvent>(_onPerformLoginEvent);
  }

  Future<void> _onPerformLoginEvent(
      PerformLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final response = await _loginUseCase.execute(event.loginRequest);
    response.fold((fail) {
      emit(LoginFailure(fail.message));
    }, (data) async {
      _appPreferences.saveAccessToken(data.accessToken);
      _appPreferences.saveUserStatus(data.verificationStatus.getStringValue());
      emit(LoginSuccess(data));
    });
  }

  final LoginUseCase _loginUseCase;
  final AppPreferences _appPreferences;
}
