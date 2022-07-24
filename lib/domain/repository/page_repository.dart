import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/page.dart';

abstract class PageRepository {
  Future<Either<CustomFailure, List<PageModel>>> getPages();
}
