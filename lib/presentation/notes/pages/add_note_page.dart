import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/presentation/notes/blocs/notes/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/request/note_requests.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state.addNoteStatus.isLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.addNoteStatus.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(context,
              title: "Add Note",
              message: state.addNoteErrorMsg,
              onClose: () => Navigator.pop(context));
        } else if (state.addNoteStatus.isSuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Add Note",
            message: "Successfully added note",
            onDone: () => Navigator.pop(context),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
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
                                final AddNoteRequest request = AddNoteRequest(
                                  content: _descCtrl.text,
                                  title: _titleCtrl.text,
                                );

                                context.read<NotesCubit>().addNote(request);
                              }
                            },
                            child: const Text("Save"),
                          )
                        ],
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
    super.dispose();
  }
}
