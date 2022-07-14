import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/domain/model/note.dart';

abstract class NoteRepository {
  Future<Either<CustomFailure, List<Note>>> getAllNotes();

  Future<Either<CustomFailure, List<Note>>> saveNote(
      AddNoteRequest addNoteRequest);

  Future<Either<CustomFailure, List<Note>>> updateNote(
      AddNoteRequest addNoteRequest);
}
