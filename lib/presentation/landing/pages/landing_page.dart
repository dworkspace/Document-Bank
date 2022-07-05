import 'package:document_bank/presentation/docs/pages/all_docs_page.dart';
import 'package:document_bank/presentation/home/pages/home_page.dart';
import 'package:document_bank/presentation/notes/pages/all_notes_page.dart';
import 'package:document_bank/presentation/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/landing/landing_cubit.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> _pages = [
    const HomePage(),
    const AllDocsPage(),
    const AllNotesPage(),
    Text("Chat"),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingCubit, LandingState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: _pages[state.navIndex]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.navIndex,
            onTap: (index) {
              context.read<LandingCubit>().changeNavIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.file_copy), label: "All Docs"),
              BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Notes"),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
          ),
        );
      },
    );
  }
}
