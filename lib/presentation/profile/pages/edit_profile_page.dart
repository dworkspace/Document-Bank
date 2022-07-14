import 'dart:io';

import 'package:document_bank/core/di%20/app_module.dart';
import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/presentation/profile/blocs/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../blocs/profile/profile_cubit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Profile get _profile => widget.profile;

  @override
  void initState() {
    super.initState();
    setupValues();
  }

  void setupValues() {
    final profile = widget.profile;
    _nameCtrl.text = profile.name;
    _usernameCtrl.text = profile.username;
    _dobCtrl.text = profile.dob;
    _countryCtrl.text = profile.country;
    _mobileCtrl.text = profile.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.editStatus.isUpdating) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.editStatus.isFailed) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Update Error",
            message: state.editErrorMsg,
            onClose: () {
              Navigator.pop(context);
            },
          );
        } else if (state.editStatus.isUpdated) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Update Success",
            message: state.editErrorMsg,
            onDone: () {
              Navigator.pop(context);
              context.read<ProfileCubit>().getProfile();
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style:
                getMediumStyle(color: ColorManager.blackColor, fontSize: 18.0),
          ),
        ),
        body: Form(
          key: _formKey,
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 10.0),
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        state.pickedPhotoFile == null
                            ? CircleAvatar(
                                radius: 60.0,
                                backgroundColor: ColorManager.darkBlue,
                                backgroundImage:
                                    NetworkImage(_profile.profileURL))
                            : CircleAvatar(
                                radius: 60.0,
                                backgroundColor: ColorManager.darkBlue,
                                backgroundImage:
                                    FileImage(state.pickedPhotoFile!),
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
                                        .read<EditProfileCubit>()
                                        .setImageFile(File(_file.path));
                                  }
                                  Navigator.pop(context);
                                },
                                onGalleryTap: () async {
                                  XFile? _file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (_file != null) {
                                    context
                                        .read<EditProfileCubit>()
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
                                  border: Border.all(
                                      color: ColorManager.grayColor)),
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
                  const SizedBox(height: 20.0),
                  CustomInputField(
                    controller: _nameCtrl,
                    hintText: "Name",
                  ),
                  CustomInputField(
                    controller: _usernameCtrl,
                    hintText: "Username",
                  ),
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
                  CustomInputField(
                    controller: _mobileCtrl,
                    hintText: "Mobile Number",
                    inputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile Number is required";
                      } 
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        UpdateProfileRequest _request = UpdateProfileRequest(
                          name: _nameCtrl.text,
                          username: _usernameCtrl.text,
                          country: _countryCtrl.text,
                          dob: _dobCtrl.text,
                          phone: _mobileCtrl.text,
                          imagePath: state.pickedPhotoFile != null
                              ? state.pickedPhotoFile!.path
                              : null,
                        );

                        context
                            .read<EditProfileCubit>()
                            .updateProfile(_request);
                      }
                    },
                    child: const Text("Update"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
