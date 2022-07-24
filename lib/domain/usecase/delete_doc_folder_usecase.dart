import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/repository/document_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class DeleteDocFolderUseCase extends BaseUseCase<int, List<Folder>> {
  final DocumentRepository _documentRepository;

  DeleteDocFolderUseCase(this._documentRepository);

  @override
  Future<Either<CustomFailure, List<Folder>>> execute(int input) async {
    return await _documentRepository.deleteDocFolder(input);
  }
}
