import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/document_requests.dart';
import 'package:document_bank/domain/model/folder.dart';

import '../model/document.dart';

abstract class DocumentRepository {
  Future<Either<CustomFailure, List<Folder>>> getAllFolders();

  Future<Either<CustomFailure, List<Document>>> storeDocuments(
      AddDocumentsRequest addDocumentsRequest);
}