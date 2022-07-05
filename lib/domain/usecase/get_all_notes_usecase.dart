import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/note.dart';
import 'package:document_bank/domain/repository/note_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetAllNotesUseCase extends BaseUseCase<void, List<Note>> {
  final NoteRepository _noteRepository;

  GetAllNotesUseCase(this._noteRepository);

  @override
  Future<Either<CustomFailure, List<Note>>> execute(void input) async {
    return await _noteRepository.getAllNotes();
  }
}
