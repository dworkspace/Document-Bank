import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/domain/model/note.dart';
import 'package:document_bank/domain/repository/note_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class UpdateNoteUseCase extends BaseUseCase<AddNoteRequest, List<Note>> {
  final NoteRepository _noteRepository;

  UpdateNoteUseCase(this._noteRepository);

  @override
  Future<Either<CustomFailure, List<Note>>> execute(
      AddNoteRequest input) async {
    return await _noteRepository.updateNote(input);
  }
}
