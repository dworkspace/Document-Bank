import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/domain/repository/note_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetNoteFoldersUseCase extends BaseUseCase<void, List<NoteFolder>> {
  final NoteRepository _noteRepository;

  GetNoteFoldersUseCase(this._noteRepository);

  @override
  Future<Either<CustomFailure, List<NoteFolder>>> execute(void input) async {
    return await _noteRepository.getNoteFolders();
  }
}
