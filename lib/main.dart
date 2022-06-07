import 'dart:async';

import 'package:document_bank/core/resources/theme_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/firebase_options.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/forgot_password/forgotpassword_cubit.dart';
import 'package:document_bank/presentation/auth/blocs/login_bloc/login_bloc.dart';
import 'package:document_bank/presentation/auth/blocs/otp_verify/otp_verify_cubit.dart';
import 'package:document_bank/presentation/auth/blocs/register/register_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di /app_module.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await initAppModule();
    runApp(const MyApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => instance<AuthBloc>()..add(AuthCheck())),
            BlocProvider(create: (_) => instance<LoginBloc>()),
            BlocProvider(create: (_) => instance<RegisterBloc>()),
            BlocProvider(create: (_) => instance<OtpVerifyCubit>()),
            BlocProvider(create: (_) => instance<ForgotpasswordCubit>()),
          ],
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            themeMode: ThemeMode.system,
            onGenerateRoute: RouteGenerator.getRoute,
            builder: (context, child) {
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, authState) {
                  switch (authState.status) {
                    case AuthStatus.loading:
                      _navigator.pushNamedAndRemoveUntil<void>(
                        Routes.splashRoute,
                        (route) => false,
                      );
                      break;
                    case AuthStatus.unauthenticated:
                      _navigator.pushNamedAndRemoveUntil<void>(
                        Routes.loginRoute,
                        (route) => false,
                      );

                      break;
                    case AuthStatus.authenticated:
                      _navigator.pushNamedAndRemoveUntil<void>(
                        Routes.landingRoute,
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
