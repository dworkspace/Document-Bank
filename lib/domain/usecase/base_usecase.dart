import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<CustomFailure, Out>> execute(In input);
}
