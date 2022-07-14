import 'package:flutter/material.dart';

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}

extension ErrorsX on Map<String, dynamic> {
  String getErrorMessage() {
    String errorMessage = "";
    forEach((key, value) {
      final _value = value;
      for (var element in _value) {
        errorMessage = errorMessage + " " + element;
      }
    });
    return errorMessage;
  }
}
