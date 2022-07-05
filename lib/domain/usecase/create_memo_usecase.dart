import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/memo_requests.dart';
import 'package:document_bank/domain/model/memo.dart';
import 'package:document_bank/domain/repository/memo_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class CreateMemoUseCase extends BaseUseCase<CreateMemoRequest, List<Memo>> {
  final MemoRepository _memoRepository;

  CreateMemoUseCase(this._memoRepository);

  @override
  Future<Either<CustomFailure, List<Memo>>> execute(
      CreateMemoRequest input) async {
    return await _memoRepository.createMemo(input);
  }
}
