import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/domain/model/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PageDetailPage extends StatefulWidget {
  const PageDetailPage({Key? key, required this.pageModel}) : super(key: key);

  final PageModel pageModel;

  @override
  State<PageDetailPage> createState() => _PageDetailPageState();
}

class _PageDetailPageState extends State<PageDetailPage> {
  PageModel get page => widget.pageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Column(
          children: [
            page.photo != null
                ? CachedNetworkImage(
                    imageUrl: page.photo!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.contain,
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: HtmlWidget(page.description),
              ),
            )
          ],
        ),
      ),
    );
  }
}
