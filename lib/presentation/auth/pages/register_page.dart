import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/router/arguments/verify_email_arg.dart';
import '../../../core/utils/functions.dart';
import '../../../data/request/auth_requests.dart';
import '../blocs/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          DialogUtils.buildLoadingDialog(context);
        }
        if (state is RegisterFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Register Failed",
            message: state.errorMessage,
            onClose: () => Navigator.pop(context),
          );
        }
        if (state is RegisterSuccess) {
          Navigator.pop(context);
          final args = VerifyEmailArg(email: _emailCtrl.text);

          SchedulerBinding.instance?.addPostFrameCallback((timestamp) {
            Navigator.pushReplacementNamed(
              context,
              Routes.emailVerifyRoute,
              arguments: args,
            );
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: getTopWidget(),
              ),
              const SizedBox(height: AppSize.s20),
              Expanded(flex: 1, child: signUpForm()),
              Expanded(
                flex: 0,
                child: bottomWidget(),
              ),
            ],
          ),
        ),
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
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: AppPadding.p16),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: getSemiBoldStyle(
                        color: ColorManager.grayColor,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const SizedBox(height: AppSize.s4),
                    Visibility(
                      visible: false,
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
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: AppPadding.p16),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: getSemiBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s4),
                  Visibility(
                    visible: true,
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

  Widget signUpForm() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return SingleChildScrollView(
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
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome To\n",
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
                    controller: _nameCtrl,
                    hintText: "Name",
                    validator: (name) {
                      final validation = nameValidation(name ?? "");
                      return validation.message;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: AppSize.s16),
                  CustomInputField(
                    controller: _emailCtrl,
                    hintText: "Email",
                    inputType: TextInputType.emailAddress,
                    validator: (email) {
                      final validation = emailValidation(email ?? "");
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
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isObSecure: true,
                  ),
                  const SizedBox(height: AppSize.s16),
                  CustomInputField(
                    controller: _confirmPasswordCtrl,
                    hintText: "Confirm Password",
                    isObSecure: true,
                    inputType: TextInputType.visiblePassword,
                    validator: (password) {
                      final validation = passwordValidation(password ?? "");
                      if (validation.message != null) {
                        return validation.message;
                      } else {
                        if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
                          return "Password and confirm password didn't match";
                        }
                      }
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: AppSize.s16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final RegisterRequest registerRequest =
                              RegisterRequest(
                            name: _nameCtrl.text,
                            email: _emailCtrl.text,
                            password: _passwordCtrl.text,
                            confirmPassword: _confirmPasswordCtrl.text,
                          );
                          context.read<RegisterBloc>().add(
                                PerformRegisterEvent(
                                    registerRequest: registerRequest),
                              );
                        }
                      },
                      child: const Text("Sign Up"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bottomWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Privacy Policy",
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
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }
}
