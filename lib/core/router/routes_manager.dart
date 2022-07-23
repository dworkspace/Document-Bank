import 'package:document_bank/core/di%20/app_module.dart';
import 'package:document_bank/core/router/arguments/add_note_args.dart';
import 'package:document_bank/core/router/arguments/reset_forgot_password_args.dart';
import 'package:document_bank/core/router/arguments/set_reminder_arg.dart';
import 'package:document_bank/core/router/arguments/verify_email_arg.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/presentation/add_document/pages/add_document_page.dart';
import 'package:document_bank/presentation/auth/pages/account_setup_page.dart';
import 'package:document_bank/presentation/auth/pages/forgot_password/forgot_password_page.dart';
import 'package:document_bank/presentation/auth/pages/forgot_password/reset_password_page.dart';
import 'package:document_bank/presentation/auth/pages/login_page.dart';
import 'package:document_bank/presentation/auth/pages/otp_verify_page.dart';
import 'package:document_bank/presentation/auth/pages/register_page.dart';
import 'package:document_bank/presentation/contacts/pages/contacts_page.dart';
import 'package:document_bank/presentation/docs/pages/folder_documents_page.dart';
import 'package:document_bank/presentation/goal/pages/top_goals_page.dart';
import 'package:document_bank/presentation/landing/pages/landing_page.dart';
import 'package:document_bank/presentation/notes/pages/add_note_page.dart';
import 'package:document_bank/presentation/notes/pages/folder_notes_page.dart';
import 'package:document_bank/presentation/profile/blocs/edit_profile/edit_profile_cubit.dart';
import 'package:document_bank/presentation/profile/pages/about_us_page.dart';
import 'package:document_bank/presentation/profile/pages/change_password_page.dart';
import 'package:document_bank/presentation/profile/pages/edit_profile_page.dart';
import 'package:document_bank/presentation/profile/pages/help_and_support_page.dart';
import 'package:document_bank/presentation/profile/pages/privacy_policy_page.dart';
import 'package:document_bank/presentation/profile/pages/terms_condition_page.dart';
import 'package:document_bank/presentation/reminder/pages/my_reminders_page.dart';
import 'package:document_bank/presentation/reminder/pages/set_reminder_page.dart';
import 'package:document_bank/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/add_document/blocs/add_documents/add_documents_bloc.dart';
import '../../presentation/auth/blocs/account_setup/account_setup_cubit.dart';
import '../../presentation/contacts/blocs/contact/contact_bloc.dart';
import '../../presentation/notes/blocs/add_note/add_note_cubit.dart';
import '../../presentation/reminder/blocs/set_reminder/set_reminder_cubit.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String accountSetupRoute = "/accountSetup";
  static const String emailVerifyRoute = "/emailVerify";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String resetPasswordRoute = "/resetPassword";
  static const String landingRoute = "/landing";
  static const String mainRoute = "/main";
  static const String addDocumentsRoute = "/addDocuments";
  static const String contactsRoute = "/contacts";
  static const String notesOfFolderRoute = "/notesOfFolder";
  static const String addNoteRoute = "/addNote";
  static const String goalsRoute = "/goals";
  static const String editProfileRoute = "/editProfile";
  static const String setReminderRoute = "/setReminder";
  static const String folderDocumentsRoute = "/folderDocuments";
  static const String myRemindersRoute = "/myReminders";
  static const String changePasswordRoute = "/changePassword";
  static const String privacyPolicyRoute = "/privacyPolicy";
  static const String helpSupportRoute = "/helpSupport";
  static const String aboutUsRoute = "/aboutUs";
  static const String termsConditionRoute = "/termsConditions";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case Routes.accountSetupRoute:
        initAccountSetupModule();
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => instance<AccountSetupCubit>(),
            child: const AccountSetupPage(),
          ),
        );
      case Routes.emailVerifyRoute:
        return MaterialPageRoute(
          builder: (_) => OtpVerifyPage(
            arg: routeSettings.arguments as VerifyEmailArg,
          ),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordPage(
                  args: routeSettings.arguments as ResetForgotPasswordArgs,
                ));
      case Routes.landingRoute:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case Routes.notesOfFolderRoute:
        return MaterialPageRoute(
            builder: (_) => FolderNotesPage(
                  noteFolder: routeSettings.arguments as NoteFolder,
                ));
      case Routes.addDocumentsRoute:
        initAddDocumentsModule();
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => instance<AddDocumentsBloc>(),
                  child: const AddDocumentPage(),
                ));
      case Routes.addNoteRoute:
        return MaterialPageRoute(
          builder: (_) => AddNotePage(
            args: routeSettings.arguments as AddNoteArg?,
          ),
        );
      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (_) => EditProfilePage(
            profile: routeSettings.arguments as Profile,
          ),
        );
      case Routes.myRemindersRoute:
        return MaterialPageRoute(builder: (_) => const MyRemindersPage());
      case Routes.termsConditionRoute:
        return MaterialPageRoute(builder: (_) => const TermsConditionsPage());
      case Routes.privacyPolicyRoute:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case Routes.aboutUsRoute:
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      case Routes.helpSupportRoute:
        return MaterialPageRoute(builder: (_) => const HelpSupportPage());
      case Routes.changePasswordRoute:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case Routes.folderDocumentsRoute:
        return MaterialPageRoute(
          builder: (_) =>
              FolderDocumentsPage(folder: routeSettings.arguments as Folder),
        );
      case Routes.goalsRoute:
        return MaterialPageRoute(
          builder: (_) => const TopGoalsPage(),
        );
      case Routes.contactsRoute:
        initContactsModule();
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => instance<ContactBloc>()..add(FetchContacts()),
            child: const ContactsPage(),
          ),
        );
      case Routes.setReminderRoute:
        initReminderModule();
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => instance<SetReminderCubit>(),
            child: SetReminderPage(
              args: routeSettings.arguments as SetReminderArg,
            ),
          ),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No route found"),
        ),
        body: const Center(
          child: Text("No route found"),
        ),
      ),
    );
  }
}
