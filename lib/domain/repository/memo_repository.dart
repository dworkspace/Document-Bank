import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/memo_requests.dart';
import 'package:document_bank/domain/model/memo.dart';

abstract class MemoRepository {
  Future<Either<CustomFailure, List<Memo>>> getImportantMemos();

  Future<Either<CustomFailure, List<Memo>>> createMemo(
      CreateMemoRequest memoRequest);
}
