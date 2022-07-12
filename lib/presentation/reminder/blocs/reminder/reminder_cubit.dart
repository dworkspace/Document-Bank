import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/domain/model/reminder.dart';
import 'package:document_bank/domain/usecase/delete_reminder_usecase.dart';
import 'package:document_bank/domain/usecase/get_reminders_usecase.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit(
    this._getRemindersUseCase,
    this._deleteReminderUseCase,
  ) : super(ReminderState()) {
    getReminders();
  }

  void getReminders() async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    final response = await _getRemindersUseCase.execute(Void);
    response.fold(
      (fail) => emit(state.copyWith(
          status: StateStatusEnum.failure, errorMsg: fail.message)),
      (data) => emit(
          state.copyWith(status: StateStatusEnum.success, reminderList: data)),
    );
  }

  void deleteReminder(int id) async {
    final response = await _deleteReminderUseCase.execute(id);
    response.fold(
      (fail) => emit(state.copyWith(reminderList: state.reminderList)),
      (data) async {
        final response = await _getRemindersUseCase.execute(Void);
        response.fold(
          (fail) => emit(state.copyWith(reminderList: state.reminderList)),
          (data) => emit(state.copyWith(reminderList: data)),
        );
      },
    );
  }

  final GetRemindersUseCase _getRemindersUseCase;
  final DeleteReminderUseCase _deleteReminderUseCase;
}
