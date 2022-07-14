import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/reminder.dart';
import 'package:document_bank/domain/repository/reminder_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetRemindersUseCase extends BaseUseCase<void, List<Reminder>> {
  final ReminderRepository _reminderRepository;

  GetRemindersUseCase(this._reminderRepository);

  @override
  Future<Either<CustomFailure, List<Reminder>>> execute(void input) async {
    return await _reminderRepository.getReminders();
  }
}
