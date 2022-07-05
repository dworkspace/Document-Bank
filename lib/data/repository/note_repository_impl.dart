import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/data/response/note_responses.dart';
import 'package:document_bank/domain/model/note.dart';
import 'package:document_bank/domain/repository/note_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  NoteRepositoryImpl(this._remoteSource, this._networkInfo);

  @override
  Future<Either<CustomFailure, List<Note>>> getAllNotes() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<NoteResponse> response = await _remoteSource.getAllNotes();
        final List<Note> notes =
            List<Note>.from(response.map((e) => Note.fromNoteResponse(e)))
                .toList();
        return Right(notes);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<Note>>> saveNote(
      AddNoteRequest addNoteRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<NoteResponse> response =
            await _remoteSource.saveNote(addNoteRequest);
        final List<Note> notes =
            List<Note>.from(response.map((e) => Note.fromNoteResponse(e)))
                .toList();
        return Right(notes);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
