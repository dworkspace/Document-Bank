import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/domain/repository/document_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetFolderDocumentsUseCase extends BaseUseCase<int, List<Document>> {
  final DocumentRepository _documentRepository;

  GetFolderDocumentsUseCase(this._documentRepository);

  @override
  Future<Either<CustomFailure, List<Document>>> execute(int input) async {
    return await _documentRepository.getDocumentsOfFolder(input);
  }
}
