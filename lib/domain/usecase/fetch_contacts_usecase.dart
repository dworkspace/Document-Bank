import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/repository/common_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';
import 'package:flutter_contacts/contact.dart';

class FetchContactsUseCase extends BaseUseCase<void, List<Contact>> {
  final CommonRepository _commonRepository;
  FetchContactsUseCase(this._commonRepository);
  @override
  Future<Either<CustomFailure, List<Contact>>> execute(void input) async {
    return await _commonRepository.fetchContacts();
  }
}
