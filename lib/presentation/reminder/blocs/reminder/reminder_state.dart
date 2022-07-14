part of 'reminder_cubit.dart';

extension ReminderStateX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isSuccess => this == StateStatusEnum.success;

  bool get isFailure => this == StateStatusEnum.failure;
}

class ReminderState {
  final StateStatusEnum status;
  final List<Reminder> reminderList;
  final String errorMessage;

  ReminderState({
    this.status = StateStatusEnum.initial,
    this.reminderList = const [],
    this.errorMessage = "",
  });

  ReminderState copyWith({
    StateStatusEnum? status,
    List<Reminder>? reminderList,
    String? errorMsg,
  }) {
    return ReminderState(
      status: status ?? this.status,
      reminderList: reminderList ?? this.reminderList,
      errorMessage: errorMsg ?? errorMessage,
    );
  }
}
