import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/reminder_requests.dart';
import 'package:document_bank/domain/model/reminder.dart';

abstract class ReminderRepository {
  Future<Either<CustomFailure, String>> addReminder(
      SetReminderRequest reminderRequest);

  Future<Either<CustomFailure, List<Reminder>>> getReminders();

  Future<Either<CustomFailure, String>> deleteReminder(int id);
}
