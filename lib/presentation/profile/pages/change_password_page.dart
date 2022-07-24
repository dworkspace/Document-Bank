import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/utils/functions.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:document_bank/presentation/profile/blocs/change_password/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordCtrl = TextEditingController();
  final TextEditingController _newPasswordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.changePasswordStatus.isLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.changePasswordStatus.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Change Password Error",
            message: state.errorMsg,
            onClose: () {
              Navigator.pop(context);
            },
          );
        } else if (state.changePasswordStatus.isSuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Change Password",
            message: state.errorMsg,
            onDone: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(LoggedOut());
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: getSemiBoldStyle(
              color: ColorManager.blackColor,
              fontSize: 16.0,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            children: [
              CustomInputField(
                controller: _currentPasswordCtrl,
                hintText: "Current password",
                validator: (password) {
                  final validation = passwordValidation(password ?? "");
                  return validation.message;
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isObSecure: true,
              ),
              const SizedBox(height: 12.0),
              CustomInputField(
                controller: _newPasswordCtrl,
                hintText: "New password",
                validator: (password) {
                  final validation = passwordValidation(password ?? "");
                  return validation.message;
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isObSecure: true,
              ),
              const SizedBox(height: 12.0),
              CustomInputField(
                controller: _confirmPasswordCtrl,
                hintText: "Confirm password",
                inputType: TextInputType.visiblePassword,
                validator: (password) {
                  final validation = passwordValidation(password ?? "");
                  if (validation.message != null) {
                    return validation.message;
                  } else {
                    if (_newPasswordCtrl.text != _confirmPasswordCtrl.text) {
                      return "New Password and confirm password didn't match";
                    }
                  }
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isObSecure: true,
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                   final  ChangePasswordRequest request = ChangePasswordRequest(
                      currentPassword: _currentPasswordCtrl.text,
                      newPassword: _newPasswordCtrl.text,
                      confirmPassword: _confirmPasswordCtrl.text,
                    );
                    context.read<ChangePasswordCubit>().changePassword(request);
                  }
                },
                child: const Text("Change"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
