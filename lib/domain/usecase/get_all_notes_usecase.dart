import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/note.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/domain/repository/note_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetAllNotesUseCase extends BaseUseCase<NoteFolder, List<Note>> {
  final NoteRepository _noteRepository;

  GetAllNotesUseCase(this._noteRepository);

  @override
  Future<Either<CustomFailure, List<Note>>> execute(NoteFolder input) async {
    return await _noteRepository.getAllNotesOfFolder(input);
  }
}
