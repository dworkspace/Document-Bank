import 'package:document_bank/core/blocs/folder_cubit.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/model/note_folder.dart';

class NoteFoldersPage extends StatelessWidget {
  const NoteFoldersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "All Notes",
                  style: getSemiBoldStyle(
                    color: ColorManager.blackColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              BlocBuilder<FolderCubit, FolderState>(
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
                    final List<NoteFolder> _noteFolders = state.noteFolders;
                    return ListView.builder(
                        itemCount: _noteFolders.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final NoteFolder noteFolder = _noteFolders[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.notesOfFolderRoute,
                                arguments: noteFolder,
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.string(
                                          noteFolder.iconSvg,
                                          color: ColorManager.grayColor,
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                      ),
                                      Text(
                                        noteFolder.title,
                                        style: getRegularStyle(
                                            color: ColorManager.blackColor
                                                .withOpacity(0.7),
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color:
                                      ColorManager.grayColor.withOpacity(0.4),
                                  height: 1.0,
                                )
                              ],
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
        Positioned(
            bottom: 24.0,
            right: 24.0,
            child: FloatingActionButton(
              backgroundColor: ColorManager.primaryYellow,
              onPressed: () {
                Navigator.pushNamed(context, Routes.addNoteRoute);
              },
              child: Icon(
                Icons.add,
                color: ColorManager.blackColor,
              ),
            )),
      ],
    );
  }
}
