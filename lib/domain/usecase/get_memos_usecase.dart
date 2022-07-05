import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/memo.dart';
import 'package:document_bank/domain/repository/memo_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetMemosUseCase extends BaseUseCase<void, List<Memo>> {
  final MemoRepository _memoRepository;

  GetMemosUseCase(this._memoRepository);

  @override
  Future<Either<CustomFailure, List<Memo>>> execute(void input) async {
    return await _memoRepository.getImportantMemos();
  }
}
