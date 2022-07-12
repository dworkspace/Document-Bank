import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/color_manager.dart';
import '../../../domain/model/document.dart';

class FolderDocumentsPage extends StatelessWidget {
  const FolderDocumentsPage({Key? key, required this.folder}) : super(key: key);
  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          folder.title,
          style: getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: 16.0,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.3,
        ),
        itemCount: folder.documents.length,
        itemBuilder: (context, index) {
          final Document _document = folder.documents[index];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: CachedNetworkImage(
              imageUrl: _document.photo,
              placeholder: (context, url) => const LinearProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
