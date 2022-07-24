import 'package:document_bank/domain/model/document.dart';

class DocViewPagerArgs {
  final List<Document> documents;
  final int currentIndex;

  DocViewPagerArgs({
    this.currentIndex = 0,
    required this.documents,
  });
}
