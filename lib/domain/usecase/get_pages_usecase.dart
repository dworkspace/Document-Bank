import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/page.dart';
import 'package:document_bank/domain/repository/page_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetPagesUseCase extends BaseUseCase<void, List<PageModel>> {
  final PageRepository _pageRepository;

  GetPagesUseCase(this._pageRepository);

  @override
  Future<Either<CustomFailure, List<PageModel>>> execute(void input) async {
    return await _pageRepository.getPages();
  }
}
