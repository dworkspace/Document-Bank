import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/memo_requests.dart';
import 'package:document_bank/data/response/memo_responses.dart';
import 'package:document_bank/domain/model/memo.dart';
import 'package:document_bank/domain/repository/memo_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class MemoRepositoryImpl extends MemoRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  MemoRepositoryImpl(this._networkInfo, this._remoteSource);

  @override
  Future<Either<CustomFailure, List<Memo>>> createMemo(
      CreateMemoRequest memoRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<MemoResponse> response =
            await _remoteSource.createMemo(memoRequest);
        final List<Memo> memos =
            List<Memo>.from(response.map((e) => e.toMemo())).toList();
        return Right(memos);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<Memo>>> getImportantMemos() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<MemoResponse> response =
            await _remoteSource.getImportantMemos();
        final List<Memo> memos =
            List<Memo>.from(response.map((e) => e.toMemo())).toList();
        return Right(memos);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
