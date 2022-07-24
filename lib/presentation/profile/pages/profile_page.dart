import 'package:document_bank/core/blocs/page/page_cubit.dart';
import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/domain/model/page.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:document_bank/presentation/profile/blocs/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_svg/flutter_svg.dart';

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
                        backgroundImage: NetworkImage(
                          _profile.profileURL,
                        ),
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
                                context, Routes.editProfileRoute,
                                arguments: _profile);
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
        const SizedBox(height: 24.0),
        BlocBuilder<PageCubit, PageState>(builder: (context, pageState) {
          if (pageState.pageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (pageState.pageStatus.failure) {
            return Center(
              child: Text(pageState.errorMessage),
            );
          } else if (pageState.pageStatus.success) {
            final List<PageModel> _pages = pageState.pages;
            return Expanded(
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // itemCount: _pages.length ,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                ),
                children: [
                  ...List.generate(_pages.length, (index) {
                    final PageModel _page = pageState.pages[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.pageDetailRoute,
                          arguments: _page,
                        );
                      },
                      child: Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.all(12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _cardWidget(
                            iconSvg: _page.iconSvg,
                            title: _page.title,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.changePasswordRoute);
                    },
                    child: Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IconAssets.eyeImg,
                            height: 24.0,
                            width: 24.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Change Password",
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
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Widget _cardWidget(
      {required String iconSvg, required String title, VoidCallback? onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.string(iconSvg),
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
