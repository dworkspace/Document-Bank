import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/font_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/arguments/verify_email_arg.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/presentation/auth/blocs/otp_verify/otp_verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/arguments/reset_forgot_password_args.dart';
import '../../../core/router/routes_manager.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({Key? key, required this.arg}) : super(key: key);

  final VerifyEmailArg arg;

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final TextEditingController _pin1Ctrl = TextEditingController();
  final TextEditingController _pin2Ctrl = TextEditingController();
  final TextEditingController _pin3Ctrl = TextEditingController();
  final TextEditingController _pin4Ctrl = TextEditingController();
  final TextEditingController _pin5Ctrl = TextEditingController();
  final TextEditingController _pin6Ctrl = TextEditingController();

  String? pinErrorMsg;
  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerifyCubit, OtpVerifyState>(
      listener: (context, state) {
        if (state is OtpVerifyLoading) {
          DialogUtils.buildLoadingDialog(context);
        }
        if (state is OtpVerifyFail) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "OTP Verification Failed",
            message: state.failMsg,
            onClose: () => Navigator.pop(context),
          );
        }
        if (state is OtpVerifySuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "OTP Verification Success",
            message: state.otpVerifyResponse.message,
            onDone: () {
              Navigator.pop(context);
              if (widget.arg.fromPage == FromEmailVerifyEnum.forgotPassword) {
                final ResetForgotPasswordArgs args = ResetForgotPasswordArgs(
                  email: state.otpVerifyResponse.email,
                  token: state.otpVerifyResponse.token ?? "",
                );
                Navigator.pushReplacementNamed(
                  context,
                  Routes.resetPasswordRoute,
                  arguments: args,
                );
              } else {
                Navigator.pushReplacementNamed(context, Routes.landingRoute);
              }
            },
          );
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
              BlocBuilder<OtpVerifyCubit, OtpVerifyState>(
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
                          if (widget.arg.fromPage ==
                              FromEmailVerifyEnum.forgotPassword) {
                            context.read<OtpVerifyCubit>().verifyOtp(
                                  pin,
                                  widget.arg.email,
                                  "/forget-password-verify-otp",
                                );
                          } else {
                            context.read<OtpVerifyCubit>().verifyOtp(
                                  pin,
                                  widget.arg.email,
                                  "/activate-account",
                                );
                          }
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
