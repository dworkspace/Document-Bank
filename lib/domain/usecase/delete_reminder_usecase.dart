import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/repository/reminder_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class DeleteReminderUseCase extends BaseUseCase<int, String> {
  final ReminderRepository _reminderRepository;

  DeleteReminderUseCase(this._reminderRepository);

  @override
  Future<Either<CustomFailure, String>> execute(int input) async {
    return await _reminderRepository.deleteReminder(input);
  }
}
