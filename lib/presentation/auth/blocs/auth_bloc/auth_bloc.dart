import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/app_prefs.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._appPreference) : super(const AuthState.unknown()) {
    on<AuthCheck>(_onAuthCheck);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final String? accessToken = await _appPreference.getAccessToken();
    await Future.delayed(const Duration(seconds: 3), () {
      if (accessToken != null && accessToken.isNotEmpty) {
        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(const AuthState.authenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {}

  final AppPreferences _appPreference;
}
