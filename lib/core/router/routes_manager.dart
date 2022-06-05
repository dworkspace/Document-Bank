import 'package:document_bank/core/di%20/app_module.dart';
import 'package:document_bank/core/router/arguments/verify_email_arg.dart';
import 'package:document_bank/presentation/auth/pages/email_confirm_page.dart';
import 'package:document_bank/presentation/auth/pages/login_page.dart';
import 'package:document_bank/presentation/auth/pages/register_page.dart';
import 'package:document_bank/presentation/landing/pages/landing_page.dart';
import 'package:document_bank/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String emailVerifyRoute = "/emailVerify";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String landingRoute = "/landing";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
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
        initEmailVerifyModule();
        return MaterialPageRoute(
          builder: (_) => EmailConfirmPage(
            arg: routeSettings.arguments as VerifyEmailArg,
          ),
        );
      case Routes.landingRoute:
        return MaterialPageRoute(builder: (_) => const LandingPage());
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
