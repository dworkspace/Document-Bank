import 'package:dio/dio.dart';
import 'package:document_bank/core/blocs/folder_cubit.dart';
import 'package:document_bank/data/network/api_client.dart';
import 'package:document_bank/data/repository/common_repository_impl.dart';
import 'package:document_bank/data/repository/document_repository_impl.dart';
import 'package:document_bank/data/repository/goal_repository_impl.dart';
import 'package:document_bank/data/repository/memo_repository_impl.dart';
import 'package:document_bank/data/repository/profile_repository_impl.dart';
import 'package:document_bank/data/repository/reminder_repository_impl.dart';
import 'package:document_bank/data/source/local_source.dart';
import 'package:document_bank/data/source/remote_source.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/repository/common_repository.dart';
import 'package:document_bank/domain/repository/document_repository.dart';
import 'package:document_bank/domain/repository/goal_repository.dart';
import 'package:document_bank/domain/repository/memo_repository.dart';
import 'package:document_bank/domain/repository/note_repository.dart';
import 'package:document_bank/domain/repository/profile_repository.dart';
import 'package:document_bank/domain/repository/reminder_repository.dart';
import 'package:document_bank/domain/usecase/account_setup_usecase.dart';
import 'package:document_bank/domain/usecase/add_note_usecase.dart';
import 'package:document_bank/domain/usecase/add_reminder_usecase.dart';
import 'package:document_bank/domain/usecase/complete_goal_usecase.dart';
import 'package:document_bank/domain/usecase/create_goal_usecase.dart';
import 'package:document_bank/domain/usecase/create_memo_usecase.dart';
import 'package:document_bank/domain/usecase/delete_all_goals_usecase.dart';
import 'package:document_bank/domain/usecase/delete_documents_usecase.dart';
import 'package:document_bank/domain/usecase/delete_reminder_usecase.dart';
import 'package:document_bank/domain/usecase/fetch_contacts_usecase.dart';
import 'package:document_bank/domain/usecase/get_all_documents_usecase.dart';
import 'package:document_bank/domain/usecase/get_all_notes_usecase.dart';
import 'package:document_bank/domain/usecase/get_memos_usecase.dart';
import 'package:document_bank/domain/usecase/get_note_folders_usecase.dart';
import 'package:document_bank/domain/usecase/get_profile_usecase.dart';
import 'package:document_bank/domain/usecase/get_reminders_usecase.dart';
import 'package:document_bank/domain/usecase/get_todo_goals_usecase.dart';
import 'package:document_bank/domain/usecase/login_usecase.dart';
import 'package:document_bank/domain/usecase/otp_verify_usecase.dart';
import 'package:document_bank/domain/usecase/register_usecase.dart';
import 'package:document_bank/domain/usecase/reset_forgot_password_use_case.dart';
import 'package:document_bank/domain/usecase/send_otp_forgot_password_usecase.dart';
import 'package:document_bank/domain/usecase/store_documents_usecase.dart';
import 'package:document_bank/domain/usecase/update_note_usecase.dart';
import 'package:document_bank/presentation/add_document/blocs/add_documents/add_documents_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/account_setup/account_setup_cubit.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/forgot_password/forgotpassword_cubit.dart';
import 'package:document_bank/presentation/auth/blocs/login_bloc/login_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/otp_verify/otp_verify_cubit.dart';
import 'package:document_bank/presentation/auth/blocs/register/register_bloc.dart';
import 'package:document_bank/presentation/contacts/blocs/contact/contact_bloc.dart';
import 'package:document_bank/presentation/docs/blocs/doc/docs_cubit.dart';
import 'package:document_bank/presentation/goal/blocs/goal_bloc.dart';
import 'package:document_bank/presentation/landing/blocs/landing/landing_cubit.dart';
import 'package:document_bank/presentation/notes/blocs/add_note/add_note_cubit.dart';
import 'package:document_bank/presentation/notes/blocs/notes/notes_cubit.dart';
import 'package:document_bank/presentation/profile/blocs/edit_profile/edit_profile_cubit.dart';
import 'package:document_bank/presentation/profile/blocs/profile/profile_cubit.dart';
import 'package:document_bank/presentation/reminder/blocs/reminder/reminder_cubit.dart';
import 'package:document_bank/presentation/reminder/blocs/set_reminder/set_reminder_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/network_info.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/note_repository_impl.dart';
import '../../domain/usecase/get_all_folders_usecase.dart';
import '../../domain/usecase/update_profile_usecase.dart';
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
  instance.registerLazySingleton<LocalSource>(() => LocalSourceImpl());

  //repositories
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<CommonRepository>(
      () => CommonRepositoryImpl(instance()));
  instance.registerLazySingleton<GoalRepository>(
      () => GoalRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<MemoRepository>(
      () => MemoRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<DocumentRepository>(
      () => DocumentRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<ReminderRepository>(
      () => ReminderRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(instance(), instance()));

  //blocs
  instance.registerLazySingleton<AuthBloc>(() => AuthBloc(instance()));
  instance.registerLazySingleton<FolderCubit>(
      () => FolderCubit(instance(), instance()));

  //common usecase
  instance.registerLazySingleton<GetAllFoldersUseCase>(
      () => GetAllFoldersUseCase(instance()));
  instance.registerLazySingleton<GetNoteFoldersUseCase>(
      () => GetNoteFoldersUseCase(instance()));

  initForgotPasswordModule();
  initEmailVerifyModule();
  initLandingModule();
  initNoteModule();
  initAddNoteModule();
  initDocumentsModule();
  initRemindersModule();
  initGoalModule();
  initProfileModule();
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

void initAccountSetupModule() {
  if (!GetIt.I.isRegistered<AccountSetupCubit>()) {
    instance.registerFactory<AccountSetupUseCase>(
        () => AccountSetupUseCase(instance()));
    instance.registerFactory<AccountSetupCubit>(
        () => AccountSetupCubit(instance(), instance()));
  }
}

void initEmailVerifyModule() {
  if (!GetIt.I.isRegistered<OtpVerifyUseCase>()) {
    instance.registerLazySingleton(() => OtpVerifyUseCase(instance()));
    instance.registerLazySingleton<OtpVerifyCubit>(
        () => OtpVerifyCubit(instance()));
  }
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ResetForgotPasswordUseCase>()) {
    instance.registerLazySingleton<ResetForgotPasswordUseCase>(
        () => ResetForgotPasswordUseCase(instance()));

    instance.registerLazySingleton<SendOtpForgotPasswordUseCase>(
        () => SendOtpForgotPasswordUseCase(instance()));

    instance.registerLazySingleton<ForgotpasswordCubit>(
        () => ForgotpasswordCubit(instance(), instance()));
  }
}

void initLandingModule() {
  if (!GetIt.I.isRegistered<LandingCubit>()) {
    instance.registerLazySingleton<LandingCubit>(() => LandingCubit());
  }
}

void initContactsModule() {
  if (!GetIt.I.isRegistered<FetchContactsUseCase>()) {
    instance.registerFactory<FetchContactsUseCase>(
        () => FetchContactsUseCase(instance()));
    instance.registerFactory<ContactBloc>(() => ContactBloc(instance()));
  }
}

void initGoalModule() {
  if (!GetIt.I.isRegistered<CreateGoalUseCase>()) {
    instance.registerFactory<CreateGoalUseCase>(
        () => CreateGoalUseCase(instance()));
    instance.registerFactory<DeleteAllGoalsUseCase>(
        () => DeleteAllGoalsUseCase(instance()));
    instance.registerFactory<CompleteGoalUseCase>(
        () => CompleteGoalUseCase(instance()));
    instance.registerFactory<GetTodoGoalsUseCase>(
        () => GetTodoGoalsUseCase(instance()));
    instance.registerFactory<GoalBloc>(
      () => GoalBloc(instance(), instance(), instance(), instance()),
    );
  }
}

void initMemoModule() {
  if (!GetIt.I.isRegistered<GetMemosUseCase>()) {
    instance
        .registerFactory<GetMemosUseCase>(() => GetMemosUseCase(instance()));
    instance.registerFactory<CreateMemoUseCase>(
        () => CreateMemoUseCase(instance()));
  }
}

void initAddDocumentsModule() {
  if (!GetIt.I.isRegistered<AddDocumentsBloc>()) {
    instance.registerFactory<AddDocumentsBloc>(
        () => AddDocumentsBloc(instance(), instance()));
    instance.registerFactory<StoreDocumentsUseCase>(
        () => StoreDocumentsUseCase(instance()));
  }
}

void initReminderModule() {
  if (!GetIt.I.isRegistered<SetReminderCubit>()) {
    instance.registerFactory(() => AddReminderUseCase(instance()));
    instance
        .registerFactory<SetReminderCubit>(() => SetReminderCubit(instance()));
  }
}

void initNoteModule() {
  if (!GetIt.I.isRegistered<GetAllNotesUseCase>()) {
    instance.registerLazySingleton<GetAllNotesUseCase>(
        () => GetAllNotesUseCase(instance()));
    instance.registerLazySingleton<NotesCubit>(() => NotesCubit(instance()));
  }
}

initAddNoteModule() {
  if (!GetIt.I.isRegistered<AddNoteUseCase>()) {
    instance.registerLazySingleton<AddNoteUseCase>(
        () => AddNoteUseCase(instance()));
    instance.registerLazySingleton<UpdateNoteUseCase>(
        () => UpdateNoteUseCase(instance()));
    instance.registerLazySingleton<AddNoteCubit>(
        () => AddNoteCubit(instance(), instance()));
  }
}

void initDocumentsModule() {
  if (!GetIt.I.isRegistered<GetAllDocumentsUseCase>()) {
    instance.registerLazySingleton<GetAllDocumentsUseCase>(
        () => GetAllDocumentsUseCase(instance()));
    instance.registerLazySingleton<DeleteDocumentsUseCase>(
        () => DeleteDocumentsUseCase(instance()));
    instance.registerLazySingleton<DocsCubit>(
        () => DocsCubit(instance(), instance()));
  }
}

void initRemindersModule() {
  if (!GetIt.I.isRegistered<GetRemindersUseCase>()) {
    instance.registerFactory(() => GetRemindersUseCase(instance()));
    instance.registerFactory(() => DeleteReminderUseCase(instance()));
    instance.registerFactory<ReminderCubit>(
        () => ReminderCubit(instance(), instance()));
  }
}

void initProfileModule() {
  if (!GetIt.I.isRegistered<GetProfileUseCase>()) {
    instance.registerLazySingleton(() => GetProfileUseCase(instance()));
    instance.registerLazySingleton(() => UpdateProfileUseCase(instance()));
    instance
        .registerLazySingleton<ProfileCubit>(() => ProfileCubit(instance()));
    instance
        .registerFactory<EditProfileCubit>(() => EditProfileCubit(instance()));
  }
}

// void initDocumentsModule() {
//   if (!GetIt.I.isRegistered<GetAllDocumentsUseCase>()) {
//     instance.registerLazySingleton<GetAllDocumentsUseCase>(
//         () => GetAllDocumentsUseCase(instance()));
//     instance.registerLazySingleton<DocsCubit>(() => DocsCubit(instance()));
//   }
// }

// void initRemindersModule() {
//   if (!GetIt.I.isRegistered<GetRemindersUseCase>()) {
//     instance.registerFactory(() => GetRemindersUseCase(instance()));
//     instance.registerFactory(() => DeleteReminderUseCase(instance()));
//     instance.registerFactory<ReminderCubit>(
//         () => ReminderCubit(instance(), instance()));
//   }
// }
