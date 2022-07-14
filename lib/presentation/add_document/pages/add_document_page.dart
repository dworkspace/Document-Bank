import 'package:document_bank/core/blocs/folder_cubit.dart';
import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/presentation/add_document/blocs/add_documents/add_documents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/arguments/set_reminder_arg.dart';

class AddDocumentPage extends StatefulWidget {
  const AddDocumentPage({Key? key}) : super(key: key);

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _docNameCtrl = TextEditingController();
  final TextEditingController _docFolderNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDocumentsBloc, AddDocumentsState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.status.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Document Upload Failed",
            message: state.errorMessage,
            onClose: () => Navigator.pop(context),
          );
        } else if (state.status.isSuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Document Upload Success",
            message: "Successfully uploaded documents",
            onDone: () {
              Navigator.pop(context);
              DialogUtils.buildSetReminderDialog(
                  context: context,
                  onNoClick: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onYesClick: () {
                    Navigator.pop(context);
                    String ids = "";
                    for (var element
                        in state.documents.take(state.documents.length - 1)) {
                      ids = element.id.toString() + ",";
                    }
                    ids = ids +
                        state.documents[state.documents.length - 1].id
                            .toString();
                    Navigator.pushNamed(
                      context,
                      Routes.setReminderRoute,
                      arguments: SetReminderArg(
                        reminderOn: ReminderOnEnum.photo,
                        ids: ids,
                      ),
                    );
                  });
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Documents",
            style: getSemiBoldStyle(
                color: ColorManager.blackColor, fontSize: 16.0),
          ),
        ),
        body: BlocBuilder<AddDocumentsBloc, AddDocumentsState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  state.isSelectFolder
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 6.0),
                          child: BlocBuilder<FolderCubit, FolderState>(
                            builder: (context, folderState) {
                              return DropdownButtonFormField(
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Select document folder";
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                items: folderState.folders
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
                                    hintText: "Select Folder"),
                              );
                            },
                          ),
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
                      context
                          .read<AddDocumentsBloc>()
                          .add(ToggleDocumentFolder());
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<AddDocumentsBloc>().add(
                                    const PickedDocFile(
                                      pickedFileFromEnum:
                                          PickedFileFromEnum.camera,
                                    ),
                                  );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      IconAssets.cameraImg,
                                      color: ColorManager.blackColor
                                          .withOpacity(0.03),
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                                    Text(
                                      "Camera".toUpperCase(),
                                      style: getSemiBoldStyle(
                                          color: ColorManager.blackColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<AddDocumentsBloc>().add(
                                    const PickedDocFile(
                                      pickedFileFromEnum:
                                          PickedFileFromEnum.gallery,
                                    ),
                                  );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      IconAssets.fileImg,
                                      color: ColorManager.blackColor
                                          .withOpacity(0.03),
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                                    Text(
                                      "Gallery".toUpperCase(),
                                      style: getSemiBoldStyle(
                                          color: ColorManager.blackColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 6.0),
                    child: Wrap(
                      children: List.generate(
                        state.pickedDocFiles.length,
                        (index) => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Image.file(
                                state.pickedDocFiles[index],
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<AddDocumentsBloc>().add(
                                      DeletePickedFile(
                                        docFile: state.pickedDocFiles[index],
                                      ),
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorManager.redColor,
                                ),
                                child: Icon(
                                  Icons.delete,
                                  color: ColorManager.whiteColor,
                                  size: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<AddDocumentsBloc, AddDocumentsState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (state.pickedDocFiles.isEmpty) {
                      DialogUtils.buildErrorMessageDialog(context,
                          title: "Select Documents",
                          message: "Please select documents to upload",
                          onClose: () {
                        Navigator.pop(context);
                      });
                    } else {
                      context.read<AddDocumentsBloc>().add(
                          StoreDocuments(folderName: _docFolderNameCtrl.text));
                      // DialogUtils.buildSetReminderDialog(
                      //   context: context,
                      //   onNoClick: () => Navigator.pop(context),
                      //   onYesClick: () {
                      //     Navigator.pop(context);
                      //     Navigator.pushNamed(context, Routes.setReminderRoute);
                      //   },
                      // );
                    }
                  }
                },
                child: const Text("Save"),
              ),
            );
          },
        ),
      ),
    );
  }
}
