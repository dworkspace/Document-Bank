import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/font_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/arguments/verify_email_arg.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/presentation/auth/blocs/email_verify/email_verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailConfirmPage extends StatefulWidget {
  const EmailConfirmPage({Key? key, required this.arg}) : super(key: key);

  final VerifyEmailArg arg;

  @override
  State<EmailConfirmPage> createState() => _EmailConfirmPageState();
}

class _EmailConfirmPageState extends State<EmailConfirmPage> {
  final TextEditingController _pin1Ctrl = TextEditingController();
  final TextEditingController _pin2Ctrl = TextEditingController();
  final TextEditingController _pin3Ctrl = TextEditingController();
  final TextEditingController _pin4Ctrl = TextEditingController();
  final TextEditingController _pin5Ctrl = TextEditingController();
  final TextEditingController _pin6Ctrl = TextEditingController();

  String? pinErrorMsg;
  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerifyCubit, EmailVerifyState>(
      listener: (context, state) {
        if (state is EmailVerifyLoading) {
          DialogUtils.buildLoadingDialog(context);
        }
        if (state is EmailVerifyFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Verify Fail",
            message: state.failMsg,
            onClose: () => Navigator.pop(context),
          );
        }
        if (state is EmailVerifySuccess) {
          Navigator.pushReplacementNamed(context, Routes.landingRoute);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Email Verification"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm your email address",
                style: getMediumStyle(
                  color: ColorManager.darkBlue,
                  fontSize: FontSize.s20,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: _pinInputField(TextFocusEnum.next, _pin1Ctrl)),
                  Expanded(
                      child: _pinInputField(TextFocusEnum.both, _pin2Ctrl)),
                  Expanded(
                      child: _pinInputField(TextFocusEnum.both, _pin3Ctrl)),
                  Expanded(
                      child: _pinInputField(TextFocusEnum.both, _pin4Ctrl)),
                  Expanded(
                      child: _pinInputField(TextFocusEnum.both, _pin5Ctrl)),
                  Expanded(
                      child: _pinInputField(TextFocusEnum.previous, _pin6Ctrl)),
                ],
              ),
              Visibility(
                visible: pinErrorMsg != null,
                child: Text(
                  "* $pinErrorMsg",
                  style: getRegularStyle(color: ColorManager.primaryBloodColor),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Didn't get code ?",
                      style: getRegularStyle(
                        color: ColorManager.darkBlue,
                      )),
                  TextSpan(
                      text: " Resend Again",
                      style: getBoldStyle(
                        color: ColorManager.darkBlue,
                      ))
                ])),
              ),
              BlocBuilder<EmailVerifyCubit, EmailVerifyState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final pin = _pin1Ctrl.text +
                            _pin2Ctrl.text +
                            _pin3Ctrl.text +
                            _pin4Ctrl.text +
                            _pin5Ctrl.text +
                            _pin6Ctrl.text;
                        if (pin.isEmpty) {
                          setState(() {
                            pinErrorMsg = "Pin is required";
                          });
                        } else if (pin.length != 6) {
                          setState(() {
                            pinErrorMsg = "Pin must be of 6 character long";
                          });
                        } else {
                          setState(() {
                            pinErrorMsg = null;
                          });
                          context
                              .read<EmailVerifyCubit>()
                              .activateAccount(pin, widget.arg.email);
                        }
                      },
                      child: const Text("Verify"),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pinInputField(
    TextFocusEnum focusEnum,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
        ],
        textInputAction: focusEnum == TextFocusEnum.previous
            ? TextInputAction.done
            : TextInputAction.next,
        onFieldSubmitted: (value) {},
        onChanged: (value) {
          if (value.length == 1) {
            if (focusEnum == TextFocusEnum.both ||
                focusEnum == TextFocusEnum.next) {
              FocusScope.of(context).nextFocus();
            }
          } else {
            if (focusEnum == TextFocusEnum.both ||
                focusEnum == TextFocusEnum.previous) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _pin1Ctrl.dispose();
    _pin2Ctrl.dispose();
    _pin3Ctrl.dispose();
    _pin4Ctrl.dispose();
    _pin5Ctrl.dispose();
    _pin6Ctrl.dispose();
    super.dispose();
  }
}

enum TextFocusEnum { next, previous, both }
