import 'package:document_bank/core/di%20/app_module.dart';
import 'package:document_bank/core/router/arguments/reset_forgot_password_args.dart';
import 'package:document_bank/core/router/arguments/verify_email_arg.dart';
import 'package:document_bank/presentation/add_document/pages/add_document_page.dart';
import 'package:document_bank/presentation/auth/pages/forgot_password/forgot_password_page.dart';
import 'package:document_bank/presentation/auth/pages/forgot_password/reset_password_page.dart';
import 'package:document_bank/presentation/auth/pages/login_page.dart';
import 'package:document_bank/presentation/auth/pages/otp_verify_page.dart';
import 'package:document_bank/presentation/auth/pages/register_page.dart';
import 'package:document_bank/presentation/contacts/pages/contacts_page.dart';
import 'package:document_bank/presentation/goal/blocs/goal_bloc.dart';
import 'package:document_bank/presentation/goal/pages/top_goals_page.dart';
import 'package:document_bank/presentation/landing/pages/landing_page.dart';
import 'package:document_bank/presentation/notes/pages/add_note_page.dart';
import 'package:document_bank/presentation/profile/pages/edit_profile_page.dart';
import 'package:document_bank/presentation/reminder/pages/set_reminder_page.dart';
import 'package:document_bank/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/add_document/blocs/add_documents/add_documents_bloc.dart';
import '../../presentation/contacts/blocs/contact/contact_bloc.dart';
import '../../presentation/reminder/blocs/set_reminder/set_reminder_cubit.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String emailVerifyRoute = "/emailVerify";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String resetPasswordRoute = "/resetPassword";
  static const String landingRoute = "/landing";
  static const String mainRoute = "/main";
  static const String addDocumentsRoute = "/addDocuments";
  static const String contactsRoute = "/contacts";
  static const String addNoteRoute = "/addNote";
  static const String goalsRoute = "/goals";
  static const String editProfileRoute = "/editProfile";
  static const String setReminderRoute = "/setReminder";
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
      case Routes.addDocumentsRoute:
        initAddDocumentsModule();
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => instance<AddDocumentsBloc>(),
                  child: const AddDocumentPage(),
                ));
      case Routes.addNoteRoute:
        return MaterialPageRoute(builder: (_) => const AddNotePage());
      case Routes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case Routes.goalsRoute:
        initGoalModule();
        return MaterialPageRoute(
          builder: (_) => BlocProvider<GoalBloc>(
            create: (_) => instance<GoalBloc>()..add(GetAllGoals()),
            child: const TopGoalsPage(),
          ),
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
            child: const SetReminderPage(),
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
