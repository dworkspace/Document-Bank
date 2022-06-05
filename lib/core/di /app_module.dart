import 'package:dio/dio.dart';
import 'package:document_bank/data/network/api_client.dart';
import 'package:document_bank/data/source/remote_source.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/activate_account_usecase.dart';
import 'package:document_bank/domain/usecase/login_usecase.dart';
import 'package:document_bank/domain/usecase/register_usecase.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/email_verify/email_verify_cubit.dart';
import 'package:document_bank/presentation/auth/blocs/login_bloc/login_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/register/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/network_info.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../utils/app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //image picker
  instance.registerLazySingleton<ImagePicker>(() => ImagePicker());

  //app preference instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //api client
  instance.registerLazySingleton<ApiClient>(() => ApiClient());

  //dio
  instance.registerLazySingleton<Dio>(() => ApiClient().dio);

  //data source
  instance
      .registerLazySingleton<RemoteSource>(() => RemoteSourceImpl(instance()));

  //repositories
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()));

  //blocs
  instance.registerLazySingleton<AuthBloc>(() => AuthBloc(instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance
        .registerFactory<LoginBloc>(() => LoginBloc(instance(), instance()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterBloc>(() => RegisterBloc(instance()));
  }
}

void initEmailVerifyModule() {
  if (!GetIt.I.isRegistered<ActivateAccountUseCase>()) {
    instance.registerFactory(() => ActivateAccountUseCase(instance()));
    instance
        .registerFactory<EmailVerifyCubit>(() => EmailVerifyCubit(instance()));
  }
}
