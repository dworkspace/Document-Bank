import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/presentation/docs/blocs/doc/docs_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/dialog_utils.dart';

class DocumentsView extends StatefulWidget {
  const DocumentsView({Key? key}) : super(key: key);

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  bool selectEnable = false;

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
          final List<Document> _documents = state.documents;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.3,
            ),
            itemCount: _documents.length,
            itemBuilder: (context, index) {
              final Document _document = _documents[index];
              return _photoWidget(_document);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _photoWidget(Document _document) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              DialogUtils.buildImageViewDialog(
                  context: context, url: _document.photo);
            },
            child: CachedNetworkImage(
              imageUrl: _document.photo,
              placeholder: (context, url) => const LinearProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
