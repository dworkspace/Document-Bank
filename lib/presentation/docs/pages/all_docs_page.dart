import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/widgets/top_bar.dart';
import 'package:document_bank/presentation/docs/widgets/documents_view.dart';
import 'package:document_bank/presentation/docs/widgets/folders_view.dart';
import 'package:flutter/material.dart';

class AllDocsPage extends StatefulWidget {
  const AllDocsPage({Key? key}) : super(key: key);

  @override
  State<AllDocsPage> createState() => _AllDocsPageState();
}

class _AllDocsPageState extends State<AllDocsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: TopBar(),
          ),
          TabBar(
            indicatorColor: ColorManager.primaryYellow,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Folders",
                  style: getSemiBoldStyle(
                    color: ColorManager.blackColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Documents",
                  style: getSemiBoldStyle(
                    color: ColorManager.blackColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
              child: TabBarView(
            children: [
              FoldersView(),
              DocumentsView(),
            ],
          ))
        ],
      ),
    );
  }
}
