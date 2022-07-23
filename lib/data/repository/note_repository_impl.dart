import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/data/response/note_responses.dart';
import 'package:document_bank/domain/model/note.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/domain/repository/note_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  NoteRepositoryImpl(this._remoteSource, this._networkInfo);

  @override
  Future<Either<CustomFailure, List<Note>>> getAllNotesOfFolder(
      NoteFolder folder) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<NoteResponse> response =
            await _remoteSource.getAllNotesOfFolder(folder);
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

  @override
  Future<Either<CustomFailure, List<Note>>> updateNote(
      AddNoteRequest addNoteRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<NoteResponse> response =
            await _remoteSource.updateNote(addNoteRequest);
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
  Future<Either<CustomFailure, List<NoteFolder>>> getNoteFolders() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<NoteFolderResponse> response =
            await _remoteSource.getNoteFolders();
        final List<NoteFolder> notes = List<NoteFolder>.from(
            response.map((e) => NoteFolder.fromNoteFolderResponse(e))).toList();
        return Right(notes);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
