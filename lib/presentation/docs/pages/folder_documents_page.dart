import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/arguments/doc_view_pager_args.dart';
import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/presentation/docs/blocs/doc/docs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/color_manager.dart';
import '../../../domain/model/document.dart';

class FolderDocumentsPage extends StatefulWidget {
  const FolderDocumentsPage({Key? key, required this.folder}) : super(key: key);
  final Folder folder;

  @override
  State<FolderDocumentsPage> createState() => _FolderDocumentsPageState();
}

class _FolderDocumentsPageState extends State<FolderDocumentsPage> {
  bool selectEnabled = false;

  @override
  void initState() {
    super.initState();
    context.read<DocsCubit>().setSelectableDocs(widget.folder.documents);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocsCubit, DocsState>(
      listener: (context, state) {
        if (state.deleteStatus.isLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.deleteStatus.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(context,
              title: "Delete Failure",
              message: state.deleteErrorMsg, onClose: () {
            Navigator.pop(context);
          });
        } else if (state.deleteStatus.isSuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(context,
              title: "Delete Success",
              message: state.deleteErrorMsg, onDone: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      },
      child: BlocBuilder<DocsCubit, DocsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.folder.title,
                style: getSemiBoldStyle(
                  color: ColorManager.blackColor,
                  fontSize: 16.0,
                ),
              ),
              actions: [
                state.isSelectEnabled
                    ? TextButton(
                        onPressed: () {
                          context.read<DocsCubit>().toggleSelectable(false);
                        },
                        child: const Text("Deselect"),
                      )
                    : TextButton(
                        onPressed: () {
                          context.read<DocsCubit>().toggleSelectable(true);
                        },
                        child: const Text("Select"),
                      ),
                state.isSelectEnabled
                    ? IconButton(
                        onPressed: () {
                          context.read<DocsCubit>().deleteDocuments();
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 18.0,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            body: BlocBuilder<DocsCubit, DocsState>(
              builder: (context, state) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: state.docs.length,
                  itemBuilder: (context, index) {
                    final SelectableDocument _document = state.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onLongPress: () {},
                        onTap: () {
                          if (!state.isSelectEnabled) {
                            final DocViewPagerArgs _args = DocViewPagerArgs(
                              currentIndex: index,
                              documents: widget.folder.documents,
                            );
                            Navigator.pushNamed(
                              context,
                              Routes.documentsViewPagerRoute,
                              arguments: _args,
                            );
                          } else {
                            context
                                .read<DocsCubit>()
                                .toggleSelectDoc(_document);
                          }
                        },
                        child: Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.topRight,
                          children: [
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: _document.photo,
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                            _document.isSelected
                                ? Container(
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorManager.whiteColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: ColorManager.whiteColor,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
