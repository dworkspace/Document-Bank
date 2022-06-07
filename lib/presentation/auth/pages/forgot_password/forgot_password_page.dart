import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/font_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/presentation/auth/blocs/forgot_password/forgotpassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/arguments/verify_email_arg.dart';
import '../../../../core/utils/functions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotpasswordCubit, ForgotpasswordState>(
      listener: (context, state) {
        if (state.requestEmailStatus != null) {
          switch (state.requestEmailStatus) {
            case ForgotPasswordActionEnum.loading:
              DialogUtils.buildLoadingDialog(context);
              break;
            case ForgotPasswordActionEnum.failure:
              Navigator.pop(context);
              DialogUtils.buildErrorMessageDialog(context,
                  title: "Forgot Password Error",
                  message: state.errorMessage ?? "Unknown Error Found",
                  onClose: () {
                Navigator.pop(context);
              });
              break;
            case ForgotPasswordActionEnum.success:
              Navigator.pop(context);
              DialogUtils.buildSuccessMessageDialog(context,
                  title: "OTP Sent",
                  message: state.sendOtpResponse!.message, onDone: () {
                Navigator.pop(context);
                final VerifyEmailArg args = VerifyEmailArg(
                  email: state.sendOtpResponse!.email,
                  fromPage: FromEmailVerifyEnum.forgotPassword,
                );
                Navigator.pushNamed(
                  context,
                  Routes.emailVerifyRoute,
                  arguments: args,
                );
              });
              break;
            default:
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
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
                  "Forgot \nPassword ?",
                  style: getSemiBoldStyle(
                    color: ColorManager.darkBlue,
                    fontSize: FontSize.s20,
                  ),
                ),
                Text(
                  "Don't worry! It happens. Please enter the email address associated with your account.",
                  style: getRegularStyle(
                    color: ColorManager.darkBlue.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                BlocBuilder<ForgotpasswordCubit, ForgotpasswordState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final args = VerifyEmailArg(
                            email: _emailCtrl.text,
                            fromPage: FromEmailVerifyEnum.forgotPassword,
                          );
                          context
                              .read<ForgotpasswordCubit>()
                              .sendOtp(_emailCtrl.text);
                          // Navigator.pushNamed(
                          //   context,
                          //   Routes.emailVerifyRoute,
                          //   arguments: args,
                          // );
                        }
                      },
                      child: const Text("Submit"),
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
    _emailCtrl.dispose();
    super.dispose();
  }
}
