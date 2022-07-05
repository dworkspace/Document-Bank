import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../blocs/contact/contact_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactFailure) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is ContactSuccess) {
            final List<Contact> _contacts = state.contacts;
            return ListView.builder(
              itemCount: _contacts.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final Contact _contact = _contacts[index];
                return Dismissible(
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: ColorManager.darkBlue.withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 24.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: const Icon(Icons.call),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: ColorManager.darkBlue.withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 24.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: const Icon(Icons.message),
                  ),
                  key: UniqueKey(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: _contact.phones[0].number,
                      );
                      UrlLauncher.launchUrl(launchUri);
                    } else if (direction == DismissDirection.endToStart) {
                      final Uri launchUri = Uri(
                        scheme: 'sms',
                        path: _contact.phones[0].number,
                      );
                      UrlLauncher.launchUrl(launchUri);
                    }
                    return false;
                  },
                  onUpdate: (details) {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: ColorManager.darkBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _contact.displayName,
                          style: getMediumStyle(
                              color: ColorManager.darkBlue, fontSize: 16.0),
                        ),
                        Text(
                          _contact.phones[0].number,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                              color: ColorManager.darkBlue.withOpacity(0.7),
                              fontSize: 12.0),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
