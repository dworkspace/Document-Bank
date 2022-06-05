import 'enum.dart';
import 'field_validation.dart';

FieldValidation emailValidation(String email) {
  if (email.isEmpty) {
    return FieldValidation(
        validEnum: FieldValidEnum.invalidate, message: "Email is empty");
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return FieldValidation(
        validEnum: FieldValidEnum.invalidate, message: "Invalid email format");
  } else {
    return FieldValidation(validEnum: FieldValidEnum.validate);
  }
}

FieldValidation passwordValidation(String password) {
  if (password.isEmpty) {
    return FieldValidation(
        validEnum: FieldValidEnum.invalidate, message: "Password is empty");
  } else if (password.length <= 6) {
    return FieldValidation(
        validEnum: FieldValidEnum.invalidate,
        message: "Password must be at least 6 character long");
  } else {
    return FieldValidation(validEnum: FieldValidEnum.validate);
  }
}

FieldValidation nameValidation(String name) {
  if (name.isEmpty) {
    return FieldValidation(
        validEnum: FieldValidEnum.invalidate, message: "Name is empty");
  } else {
    final nameList = name.split(" ");
    if (nameList.length < 2) {
      return FieldValidation(
          validEnum: FieldValidEnum.invalidate,
          message: "First and last name required");
    } else {
      if (nameList[1].isEmpty) {
        return FieldValidation(
            validEnum: FieldValidEnum.invalidate,
            message: "Last name required");
      } else {
        return FieldValidation(validEnum: FieldValidEnum.validate);
      }
    }
  }
}
