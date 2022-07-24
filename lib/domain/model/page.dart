import 'package:document_bank/data/response/page_responses.dart';

class PageModel {
  final String title;
  final String iconSvg;
  final String? subTitle;
  final String description;
  final String? photo;

  PageModel({
    required this.title,
    required this.iconSvg,
    required this.description,
    this.subTitle,
    this.photo,
  });

  factory PageModel.fromPageResponse(PageResponse response) {
    return PageModel(
      title: response.title,
      iconSvg: response.iconSvg,
      description: response.description,
      subTitle: response.subTitle,
      photo: response.photo,
    );
  }
}
