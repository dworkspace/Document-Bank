import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/domain/repository/document_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class DeleteDocumentsUseCase extends BaseUseCase<String, List<Document>> {
  final DocumentRepository _documentRepository;

  DeleteDocumentsUseCase(this._documentRepository);

  @override
  Future<Either<CustomFailure, List<Document>>> execute(String input) async {
    return await _documentRepository.deleteDocuments(input);
  }
}
