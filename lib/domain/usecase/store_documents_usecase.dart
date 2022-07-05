import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/document_requests.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/domain/repository/document_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class StoreDocumentsUseCase
    extends BaseUseCase<AddDocumentsRequest, List<Document>> {
  final DocumentRepository _documentRepository;

  StoreDocumentsUseCase(this._documentRepository);

  @override
  Future<Either<CustomFailure, List<Document>>> execute(
      AddDocumentsRequest input) async {
    return await _documentRepository.storeDocuments(input);
  }
}
