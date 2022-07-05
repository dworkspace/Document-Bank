import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/exceptions.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/source/local_source.dart';
import 'package:document_bank/domain/repository/common_repository.dart';
import 'package:flutter_contacts/contact.dart';

class CommonRepositoryImpl extends CommonRepository {
  final LocalSource _localSource;
  CommonRepositoryImpl(this._localSource);
  @override
  Future<Either<CustomFailure, List<Contact>>> fetchContacts() async {
    try {
      final List<Contact> contactList =
          await _localSource.fetchMobileContacts();
      return Right(contactList);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.message));
    }
  }
}
