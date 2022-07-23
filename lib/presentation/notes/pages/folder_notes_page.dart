import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/arguments/add_note_args.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/presentation/notes/blocs/notes/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/note.dart';

class FolderNotesPage extends StatefulWidget {
  const FolderNotesPage({Key? key, required this.noteFolder}) : super(key: key);

  final NoteFolder noteFolder;

  @override
  State<FolderNotesPage> createState() => _FolderNotesPageState();
}

class _FolderNotesPageState extends State<FolderNotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getFolderNotes(widget.noteFolder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.noteFolder.title),
        ),
        body: BlocBuilder<NotesCubit, NotesState>(
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
              final List<Note> _notes = state.notes;
              return ListView.builder(
                  itemCount: _notes.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final Note note = _notes[index];
                    return Dismissible(
                      key: Key(index.toString()),
                      background: Container(
                        color: ColorManager.redColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      onDismissed: (direction) {
                        //todo: remove data from list
                      },
                      child: GestureDetector(
                        onTap: () {
                          final AddNoteArg args = AddNoteArg(
                            title: note.title,
                            description: note.content,
                            id: note.id,
                            noteFolder: widget.noteFolder,
                          );
                          Navigator.pushNamed(
                            context,
                            Routes.addNoteRoute,
                            arguments: args,
                          );
                        },
                        child: Container(
                          width: double.infinity,
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
                                note.title,
                                style: getMediumStyle(
                                    color: ColorManager.darkBlue,
                                    fontSize: 16.0),
                              ),
                              Text(
                                note.content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: getRegularStyle(
                                    color:
                                        ColorManager.darkBlue.withOpacity(0.7),
                                    fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
