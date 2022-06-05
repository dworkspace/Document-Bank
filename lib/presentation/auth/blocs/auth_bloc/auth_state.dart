part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  loading,
  appFirstOnboarded,
  authenticated,
  unauthenticated,
  unverified,
}

class AuthState {
  const AuthState._({
    this.status = AuthStatus.loading,
  });

  const AuthState.unknown() : this._();

  const AuthState.loading() : this._();

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.unverified() : this._(status: AuthStatus.unverified);

  const AuthState.appFirstOnBoarded()
      : this._(status: AuthStatus.appFirstOnboarded);

  final AuthStatus status;
}
