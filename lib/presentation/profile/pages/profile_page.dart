import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
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
        Column(
          children: [
            const CircleAvatar(radius: 50.0),
            Text(
              "Shree Hari Yadav",
              style: getSemiBoldStyle(
                color: ColorManager.blackColor,
                fontSize: 18.0,
              ),
            ),
            Text(
              "Nepal",
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
                    text: "2057/10/11",
                    style: getMediumStyle(
                      color: ColorManager.blackColor,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Joined On : ",
                    style: getSemiBoldStyle(
                      color: ColorManager.darkBlue,
                      fontSize: 18.0,
                    ),
                  ),
                  TextSpan(
                    text: "2057/10/11",
                    style: getMediumStyle(
                      color: ColorManager.blackColor,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: MaterialButton(
                color: ColorManager.whiteColor,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.editProfileRoute);
                },
                child: Row(
                  children: [
                    Image.asset(IconAssets.editImg),
                    const SizedBox(width: 10.0),
                    Text(
                      "Edit Profile",
                      style: getMediumStyle(
                          color: ColorManager.darkBlue, fontSize: 16.0),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        GridView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            final CardContent cardContent = index.getCardContent();
            return Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _cardWidget(
                  file: cardContent.iconImage,
                  title: cardContent.title,
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _cardWidget({required String file, required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          file,
          height: 60,
          width: 60,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            color: ColorManager.blackColor,
            fontSize: 18.0,
          ),
        )
      ],
    );
  }
}

extension CardContentX on int {
  CardContent getCardContent() {
    if (this == 0) {
      return CardContent(
          title: "Documents Folder", iconImage: IconAssets.fileImg);
    } else if (this == 1) {
      return CardContent(title: "Memos", iconImage: IconAssets.memoImg);
    } else if (this == 2) {
      return CardContent(title: "Goals", iconImage: IconAssets.userMenu);
    } else if (this == 3) {
      return CardContent(
          title: "Auto saved contacts", iconImage: IconAssets.contactImg);
    } else {
      return CardContent(
          title: "Documents Folder", iconImage: IconAssets.fileImg);
    }
  }
}

class CardContent {
  final String title;
  final String iconImage;

  CardContent({required this.title, required this.iconImage});
}