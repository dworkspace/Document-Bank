import 'package:document_bank/core/blocs/folder_cubit.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/arguments/add_note_args.dart';
import 'package:document_bank/core/router/arguments/set_reminder_arg.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/presentation/notes/blocs/add_note/add_note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/routes_manager.dart';
import '../../../data/request/note_requests.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key, this.args}) : super(key: key);
  final AddNoteArg? args;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _docFolderNameCtrl = TextEditingController();

  AddNoteArg? get args => widget.args;

  @override
  void initState() {
    super.initState();
    setupForEdit();
  }

  setupForEdit() {
    if (args != null) {
      _titleCtrl.text = args!.title;
      _descCtrl.text = args!.description;
      _docFolderNameCtrl.text = args!.noteFolder.title;
      context.read<AddNoteCubit>().toggleDocumentFolder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNoteCubit, AddNoteState>(
      listener: (context, state) {
        if (state.addNoteStatus.loading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.addNoteStatus.failure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(context,
              title: "Add Note",
              message: state.addNoteErrorMsg,
              onClose: () => Navigator.pop(context));
        } else if (state.addNoteStatus.success) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Add Note",
            message: "Successfully added note",
            onDone: () {
              Navigator.pop(context);
              if (args != null) {
                Navigator.pop(context);
              } else {
                DialogUtils.buildSetReminderDialog(
                    context: context,
                    onNoClick: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    onYesClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        Routes.setReminderRoute,
                        arguments: SetReminderArg(
                          reminderOn: ReminderOnEnum.note,
                          noteId: state.notes[0].id.toString(),
                        ),
                      );
                    });
              }
            },
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<AddNoteCubit, AddNoteState>(
          builder: (context, state) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (args == null) {
                                  final AddNoteRequest request = AddNoteRequest(
                                    content: _descCtrl.text,
                                    title: _titleCtrl.text,
                                    folder: _docFolderNameCtrl.text,
                                  );
                                  context.read<AddNoteCubit>().addNote(request);
                                } else {
                                  final AddNoteRequest request = AddNoteRequest(
                                    content: _descCtrl.text,
                                    title: _titleCtrl.text,
                                    folder: _docFolderNameCtrl.text,
                                    id: args!.id,
                                  );
                                  context
                                      .read<AddNoteCubit>()
                                      .updateNote(request);
                                }
                              }
                            },
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    ),
                    state.isSelectFolder
                        ? BlocBuilder<FolderCubit, FolderState>(
                            builder: (context, folderState) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 6.0),
                                child: DropdownButtonFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Select note folder";
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  items: folderState.noteFolders
                                      .map(
                                        (folder) => DropdownMenuItem(
                                          value: folder.title,
                                          child: Text(folder.title),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? value) {
                                    _docFolderNameCtrl.text = value ?? "";
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Select Note Folder"),
                                ),
                              );
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 6.0),
                            child: CustomInputField(
                              controller: _docFolderNameCtrl,
                              hintText: "Document Folder Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Document Folder Name is Required";
                                }
                                return null;
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        context.read<AddNoteCubit>().toggleDocumentFolder();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 6.0),
                        child: Text(
                          state.isSelectFolder
                              ? "Add New Folder +"
                              : "Select From Folder",
                          style: getMediumStyle(color: ColorManager.blackColor),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _titleCtrl,
                      style: getSemiBoldStyle(
                          color: ColorManager.blackColor, fontSize: 16.0),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter title of note";
                        }
                        return null;
                      },
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                        hintStyle: getSemiBoldStyle(
                            color: ColorManager.grayColor, fontSize: 16.0),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _descCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter note description";
                          }
                          return null;
                        },
                        style: getRegularStyle(
                            color: ColorManager.blackColor, fontSize: 16.0),
                        minLines: 1,
                        maxLines: 20,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Type something...',
                          border: InputBorder.none,
                          hintStyle: getRegularStyle(
                              color: ColorManager.grayColor, fontSize: 16.0),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _docFolderNameCtrl.dispose();
    super.dispose();
  }
}
