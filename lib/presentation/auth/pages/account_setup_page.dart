import 'dart:io';

import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/presentation/auth/blocs/account_setup/account_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/di /app_module.dart';
import '../../../core/utils/dialog_utils.dart';

class AccountSetupPage extends StatefulWidget {
  const AccountSetupPage({Key? key}) : super(key: key);

  @override
  State<AccountSetupPage> createState() => _AccountSetupPageState();
}

class _AccountSetupPageState extends State<AccountSetupPage> {
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Setup",
          style: getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: 16.0,
          ),
        ),
      ),
      body: BlocBuilder<AccountSetupCubit, AccountSetupState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: ColorManager.darkBlue,
                        backgroundImage: state.profileImageFile != null
                            ? FileImage(state.profileImageFile!)
                            : null,
                      ),
                      Positioned(
                        bottom: 8.0,
                        right: 2.0,
                        child: GestureDetector(
                          onTap: () {
                            final imagePicker = instance<ImagePicker>();
                            DialogUtils.buildPhotoPickerDialog(
                              context: context,
                              onCameraTap: () async {
                                XFile? _file = await imagePicker.pickImage(
                                    source: ImageSource.camera);
                                if (_file != null) {
                                  context
                                      .read<AccountSetupCubit>()
                                      .setImageFile(File(_file.path));
                                }
                                Navigator.pop(context);
                              },
                              onGalleryTap: () async {
                                XFile? _file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (_file != null) {
                                  context
                                      .read<AccountSetupCubit>()
                                      .setImageFile(File(_file.path));
                                }
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: ColorManager.grayColor)),
                            child: Image.asset(
                              IconAssets.cameraImg,
                              height: 16.0,
                              width: 16.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 14.0),
                CustomInputField(
                  controller: _usernameCtrl,
                  hintText: "Username",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 8.0),
                CustomInputField(
                  controller: _dobCtrl,
                  hintText: "DOB",
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "DOB is required";
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  suffixIcon: Image.asset(
                    IconAssets.calenderImg,
                    height: 16.0,
                    width: 16.0,
                  ),
                  onFieldTap: () async {
                    final dateTime =
                        await DialogUtils.inputDateFromUser(context);
                    if (dateTime != null) {
                      setState(() {
                        _dobCtrl.text =
                            DateFormat("yyyy-MM-dd").format(dateTime);
                      });
                    }
                  },
                ),
                const SizedBox(height: 8.0),
                CustomInputField(
                  controller: _countryCtrl,
                  hintText: "Country",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country is required";
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 8.0),
                CustomInputField(
                  controller: _mobileCtrl,
                  hintText: "Mobile Number",
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile Number is required";
                    } else if (value.length != 10) {
                      return "Invalid Mobile number";
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        state.profileImageFile != null) {
                      //todo: setup profile
                    }
                  },
                  child: const Text("Save"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
