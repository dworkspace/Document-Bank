import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:document_bank/presentation/profile/blocs/profile/profile_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Profile",
                style: getSemiBoldStyle(
                  color: ColorManager.blackColor,
                  fontSize: 16.0,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LoggedOut());
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isFailure) {
              return Center(
                child: Text(state.errorMsg),
              );
            } else if (state.status.isSuccess) {
              final Profile _profile = state.profile!;
              return Column(
                children: [
                  Column(
                    children: [
                       CircleAvatar(
                        radius: 50.0,
                         backgroundImage:  NetworkImage(_profile.profileURL,),
                      ),
                      Text(
                        _profile.name,
                        style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        _profile.country,
                        style: getMediumStyle(
                          color: ColorManager.blackColor,
                          fontSize: 16.0,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "DOB : ",
                              style: getSemiBoldStyle(
                                color: ColorManager.darkBlue,
                                fontSize: 18.0,
                              ),
                            ),
                            TextSpan(
                              text: _profile.dob,
                              style: getMediumStyle(
                                color: ColorManager.blackColor,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: "Joined On : ",
                      //         style: getSemiBoldStyle(
                      //           color: ColorManager.darkBlue,
                      //           fontSize: 18.0,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: "2057/10/11",
                      //         style: getMediumStyle(
                      //           color: ColorManager.blackColor,
                      //           fontSize: 18.0,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: MaterialButton(
                          color: ColorManager.whiteColor,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.editProfileRoute,arguments: _profile);
                          },
                          child: Row(
                            children: [
                              Image.asset(IconAssets.editImg),
                              const SizedBox(width: 10.0),
                              Text(
                                "Edit Profile",
                                style: getMediumStyle(
                                    color: ColorManager.darkBlue,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        GridView.builder(
          itemCount: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.5),
          itemBuilder: (context, index) {
            final CardContent cardContent = index.getCardContent(context);
            return Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _cardWidget(
                  file: cardContent.iconImage,
                  title: cardContent.title,
                  onTap: cardContent.onTap,
                ),
              ),
            );
          },
        )
      ],
    );
    ;
  }

  Widget _cardWidget(
      {required String file, required String title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              file,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  color: ColorManager.blackColor,
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension CardContentX on int {
  CardContent getCardContent(context) {
    if (this == 0) {
      return CardContent(
          title: "My Reminders",
          iconImage: IconAssets.calenderImg,
          onTap: () {
            Navigator.pushNamed(context, Routes.myRemindersRoute);
          });
    } else if (this == 1) {
      return CardContent(
        title: "Terms Conditions",
        iconImage: IconAssets.paperImg,
        onTap: () {
          Navigator.pushNamed(context, Routes.termsConditionRoute);
        },
      );
    } else if (this == 2) {
      return CardContent(
        title: "Privacy Policy",
        iconImage: IconAssets.keyLockImg,
        onTap: () {
          Navigator.pushNamed(context, Routes.privacyPolicyRoute);
        },
      );
    } else if (this == 3) {
      return CardContent(
        title: "About Us",
        iconImage: IconAssets.aboutUsImg,
        onTap: () {
          Navigator.pushNamed(context, Routes.aboutUsRoute);
        },
      );
    } else if (this == 4) {
      return CardContent(
        title: "Help and Support",
        iconImage: IconAssets.personCheckImg,
        onTap: () {
          Navigator.pushNamed(context, Routes.helpSupportRoute);
        },
      );
    } else if (this == 5) {
      return CardContent(
        title: "Change Password",
        iconImage: IconAssets.eyeImg,
        onTap: () {
          Navigator.pushNamed(context, Routes.changePasswordRoute);
        },
      );
    } else {
      return CardContent(
          title: "Documents Folder", iconImage: IconAssets.fileImg);
    }
  }
}

class CardContent {
  final String title;
  final String iconImage;
  final VoidCallback? onTap;

  CardContent({
    required this.title,
    required this.iconImage,
    this.onTap,
  });
}
