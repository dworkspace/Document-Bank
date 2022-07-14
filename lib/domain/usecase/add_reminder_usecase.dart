import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/reminder_requests.dart';
import 'package:document_bank/domain/repository/reminder_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class AddReminderUseCase extends BaseUseCase<SetReminderRequest, String> {
  final ReminderRepository _reminderRepository;

  AddReminderUseCase(this._reminderRepository);

  @override
  Future<Either<CustomFailure, String>> execute(
      SetReminderRequest input) async {
    return await _reminderRepository.addReminder(input);
  }
}
