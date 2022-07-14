import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/data/request/reminder_requests.dart';
import 'package:document_bank/domain/usecase/add_reminder_usecase.dart';

part 'set_reminder_state.dart';

class SetReminderCubit extends Cubit<SetReminderState> {
  SetReminderCubit(this._addReminderUseCase) : super(SetReminderState());

  void toggleRecurring() {
    bool isChecked = state.isRecurringChecked;
    emit(state.copyWith(isRecurringChecked: !isChecked));
  }

  void addReminder(SetReminderRequest reminderRequest) async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    final response = await _addReminderUseCase.execute(reminderRequest);

    response.fold(
      (fail) => emit(state.copyWith(
          status: StateStatusEnum.failure,
          addReminderFailMessage: fail.message)),
      (data) => emit(state.copyWith(
          status: StateStatusEnum.success, addReminderSuccessMsg: data)),
    );
  }

  final AddReminderUseCase _addReminderUseCase;
}
