import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class DocFolder extends StatelessWidget {
  const DocFolder({Key? key, required this.folder}) : super(key: key);
  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: _cacheImage(
                      folder.documents[0].photo,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.darkBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(6.0),
              alignment: Alignment.center,
              child: Text(
                folder.title,
                style: getRegularStyle(
                  color: ColorManager.whiteColor,
                  fontSize: 14.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cacheImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const LinearProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
