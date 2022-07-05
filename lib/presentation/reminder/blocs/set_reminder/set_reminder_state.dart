part of 'set_reminder_cubit.dart';

extension SetReminderStateX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isFailure => this == StateStatusEnum.failure;

  bool get isSuccess => this == StateStatusEnum.success;
}

class SetReminderState {
  final bool isRecurringChecked;

  final String? title;
  final String? selectedDate;
  final String? selectedTime;
  final String? recurringDate;
  final String? recurringText;
  final bool isFormValid;

  SetReminderState({
    this.isRecurringChecked = false,
    this.title,
    this.recurringDate,
    this.recurringText,
    this.selectedDate,
    this.selectedTime,
    this.isFormValid = false,
  });

  SetReminderState copyWith({
    bool? isRecurringChecked,
    String? title,
    String? selectedDate,
    String? selectedTime,
    String? recurringDate,
    bool? isFormValid,
    String? recurringText,
  }) {
    return SetReminderState(
      isRecurringChecked: isRecurringChecked ?? this.isRecurringChecked,
      title: title ?? this.title,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      recurringDate: recurringDate ?? this.recurringDate,
      recurringText: recurringText ?? this.recurringText,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
