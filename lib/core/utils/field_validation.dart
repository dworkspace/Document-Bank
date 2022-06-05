import 'enum.dart';

class FieldValidation {
  final FieldValidEnum validEnum;
  final String? message;

  FieldValidation({
    this.validEnum = FieldValidEnum.none,
    this.message,
  });
}
