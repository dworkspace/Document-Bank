import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/font_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/resources/values_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di /app_module.dart';
import '../../../core/router/routes_manager.dart';
import '../../../core/utils/functions.dart';
import '../../../data/request/auth_requests.dart';
import '../blocs/login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state is LoginFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Login Failed",
            message: state.errorMsg,
            onClose: () {
              Navigator.pop(context);
            },
          );
        } else if (state is LoginSuccess) {
          Navigator.pop(context);
          SchedulerBinding.instance?.addPostFrameCallback((timestamp) {
            context.read<AuthBloc>().add(LoggedIn());
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                getTopWidget(),
                const SizedBox(height: AppSize.s100),
                _loginForm(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomWidget(),
      ),
    );
  }

  Widget getTopWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p24),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: AppPadding.p16),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: getSemiBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s4),
                  Visibility(
                    visible: true,
                    child: Container(
                      width: AppSize.s40,
                      height: AppSize.s4,
                      color: ColorManager.primaryOpacity70,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.registerRoute);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: AppPadding.p16),
                child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: getSemiBoldStyle(
                        color: ColorManager.grayColor,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const SizedBox(height: AppSize.s4),
                    Visibility(
                      visible: false,
                      child: Container(
                        width: AppSize.s60,
                        height: AppSize.s4,
                        color: ColorManager.primaryYellow,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              "assets/images/db-logo.png",
              height: AppSize.s50,
              width: AppSize.s50,
            ),
          ))
        ],
      ),
    );
  }

  Widget _loginForm() {
    return BlocProvider(
      create: (context) => instance<LoginBloc>(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p10,
            horizontal: AppPadding.p16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome back\n",
                        style: getSemiBoldStyle(
                          color: ColorManager.darkBlue,
                          fontSize: AppSize.s16,
                        ),
                      ),
                      TextSpan(
                        text: "Document Bank",
                        style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: AppSize.s24,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s50),
                CustomInputField(
                  controller: _emailCtrl,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                  validator: (email) {
                    var validation = emailValidation(email ?? "");
                    return validation.message;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: AppSize.s16),
                CustomInputField(
                  controller: _passwordCtrl,
                  hintText: "Password",
                  inputType: TextInputType.visiblePassword,
                  validator: (password) {
                    final validation = passwordValidation(password ?? "");
                    return validation.message;
                  },
                  isObSecure: true,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: AppSize.s16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final _loginRequest = LoginRequest(
                            email: _emailCtrl.text,
                            password: _passwordCtrl.text);
                        context
                            .read<LoginBloc>()
                            .add(PerformLoginEvent(_loginRequest));
                      }
                    },
                    child: const Text("Login"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Forgot Password?",
            style: getRegularStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s16,
            ),
          ),
          Text(
            "Contact Support",
            style: getRegularStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s16,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }
}
