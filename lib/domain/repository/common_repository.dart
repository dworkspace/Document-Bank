import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:flutter_contacts/contact.dart';

abstract class CommonRepository {
  Future<Either<CustomFailure, List<Contact>>> fetchContacts();
}
