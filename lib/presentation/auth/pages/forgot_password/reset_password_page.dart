import 'package:document_bank/core/router/arguments/reset_forgot_password_args.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../../blocs/forgot_password/forgotpassword_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key, required this.args}) : super(key: key);
  final ResetForgotPasswordArgs args;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotpasswordCubit, ForgotpasswordState>(
      listener: (context, state) {
        if (state.resetPasswordStatus != null) {
          switch (state.resetPasswordStatus) {
            case ForgotPasswordActionEnum.loading:
              DialogUtils.buildLoadingDialog(context);
              break;
            case ForgotPasswordActionEnum.failure:
              Navigator.pop(context);
              DialogUtils.buildErrorMessageDialog(context,
                  title: "Reset Password Failed",
                  message: state.errorMessage ?? "Unknown Error Found",
                  onClose: () {
                Navigator.pop(context);
              });
              break;
            case ForgotPasswordActionEnum.success:
              Navigator.pop(context);
              DialogUtils.buildSuccessMessageDialog(
                context,
                title: "Password Reset Success",
                message: state.resetPasswordResponse!.message,
                onDone: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
              );
              break;
            default:
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reset Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 50.0,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "Reset \nPassword",
                  style: getSemiBoldStyle(
                    color: ColorManager.darkBlue,
                    fontSize: FontSize.s20,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _newPasswordCtrl,
                  hintText: "New Password",
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
                      if (_newPasswordCtrl.text != _confirmPasswordCtrl.text) {
                        return "Password and confirm password didn't match";
                      }
                    }
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: AppSize.s16),
                BlocBuilder<ForgotpasswordCubit, ForgotpasswordState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final ResetPasswordRequest request =
                              ResetPasswordRequest(
                            email: widget.args.email,
                            password: _newPasswordCtrl.text,
                            confirmPassword: _confirmPasswordCtrl.text,
                            token: widget.args.token,
                          );

                          context
                              .read<ForgotpasswordCubit>()
                              .resetPassword(request);
                        }
                      },
                      child: const Text("Reset"),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }
}
