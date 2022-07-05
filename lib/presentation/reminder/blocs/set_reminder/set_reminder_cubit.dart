import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';

part 'set_reminder_state.dart';

class SetReminderCubit extends Cubit<SetReminderState> {
  SetReminderCubit() : super(SetReminderState());

  void toggleRecurring() {
    bool isChecked = state.isRecurringChecked;
    emit(state.copyWith(isRecurringChecked: !isChecked));
  }

  void onTitleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void onDateChanged(String date) {
    emit(state.copyWith(selectedDate: date));
  }

  void onTimeChanged(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  void onRecurringDateChanged(String date) {
    emit(state.copyWith(recurringDate: date));
  }

  void onRecurringTextChanged(String recurring) {
    emit(state.copyWith(recurringText: recurring));
  }

  bool isFormValid() {
    if (state.isRecurringChecked) {
      return state.title != null &&
          state.selectedDate != null &&
          state.selectedTime != null &&
          state.recurringDate != null &&
          state.recurringText != null;
    } else {
      return state.title != null &&
          state.selectedDate != null &&
          state.selectedTime != null;
    }
  }
}
