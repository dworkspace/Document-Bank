import 'package:document_bank/core/widgets/doc_folder.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/presentation/docs/blocs/doc/docs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/routes_manager.dart';

class FoldersView extends StatefulWidget {
  const FoldersView({Key? key}) : super(key: key);

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsCubit, DocsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state.status.isSuccess) {
          final List<Folder> _folders = state.folders;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _folders.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final Folder _folder = _folders[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.folderDocumentsRoute,
                        arguments: _folder,
                      );
                    },
                    child: DocFolder(
                      folder: _folder,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
