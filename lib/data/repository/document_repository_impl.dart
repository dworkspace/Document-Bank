import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/document_requests.dart';
import 'package:document_bank/data/response/document_responses.dart';
import 'package:document_bank/domain/model/add_document.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/repository/document_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class DocumentRepositoryImpl extends DocumentRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  DocumentRepositoryImpl(this._networkInfo, this._remoteSource);

  @override
  Future<Either<CustomFailure, List<Folder>>> getAllFolders() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<FolderResponse> response =
            await _remoteSource.getAllFolders();
        final List<Folder> folders =
            List<Folder>.from(response.map((e) => Folder.fromFolderResponse(e)))
                .toList();
        return Right(folders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<AddDocument>>> storeDocuments(
      AddDocumentsRequest addDocumentsRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<AddDocumentResponse> response =
            await _remoteSource.addDocuments(addDocumentsRequest);
        final List<AddDocument> addDocuments = List<AddDocument>.from(
                response.map((e) => AddDocument.fromAddDocumentResponse(e)))
            .toList();
        return Right(addDocuments);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<Document>>> getAllDocuments() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<DocumentResponse> response =
            await _remoteSource.getAllDocuments();
        final List<Document> documents = List<Document>.from(
            response.map((e) => Document.fromDocumentResponse(e))).toList();
        return Right(documents);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<Document>>> getDocumentsOfFolder(
      int folderId) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<DocumentResponse> response =
            await _remoteSource.getDocumentsOfFolder(folderId);
        final List<Document> documents = List<Document>.from(
            response.map((e) => Document.fromDocumentResponse(e))).toList();
        return Right(documents);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<Document>>> deleteDocuments(
      String ids) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<DocumentResponse> response =
            await _remoteSource.deleteDocuments(ids);
        final List<Document> documents = List<Document>.from(
            response.map((e) => Document.fromDocumentResponse(e))).toList();
        return Right(documents);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
