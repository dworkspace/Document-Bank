part of 'set_reminder_cubit.dart';

extension SetReminderStateX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isFailure => this == StateStatusEnum.failure;

  bool get isSuccess => this == StateStatusEnum.success;
}

class SetReminderState {
  final bool isRecurringChecked;
  final StateStatusEnum status;
  final String addReminderSuccessMsg;
  final String addReminderFailMessage;

  SetReminderState({
    this.isRecurringChecked = false,
    this.status = StateStatusEnum.initial,
    this.addReminderFailMessage = "",
    this.addReminderSuccessMsg = "",
  });

  SetReminderState copyWith({
    bool? isRecurringChecked,
    StateStatusEnum? status,
    String? addReminderSuccessMsg,
    String? addReminderFailMessage,
  }) {
    return SetReminderState(
      isRecurringChecked: isRecurringChecked ?? this.isRecurringChecked,
      status: status ?? StateStatusEnum.initial,
      addReminderFailMessage:
          addReminderFailMessage ?? this.addReminderFailMessage,
      addReminderSuccessMsg:
          addReminderSuccessMsg ?? this.addReminderSuccessMsg,
    );
  }
}
