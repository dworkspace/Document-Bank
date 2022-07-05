import 'package:document_bank/core/widgets/doc_folder.dart';
import 'package:flutter/material.dart';

class FoldersView extends StatefulWidget {
  const FoldersView({Key? key}) : super(key: key);

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: DocFolder(),
          );
        },
      ),
    );
  }
}
