import 'package:document_bank/core/utils/enum.dart';

class SetReminderRequest {
  final String title;
  final String date;
  final int recurring;
  final String? endDate;
  final String? recurringPeriod;
  final String time;
  final String? id;
  final String? ids;
  final ReminderOnEnum reminderOn;

  SetReminderRequest({
    required this.title,
    required this.date,
    required this.time,
    required this.recurring,
    this.endDate,
    this.recurringPeriod,
    this.id,
    this.ids,
    this.reminderOn = ReminderOnEnum.photo,
  });

  Map<String, dynamic> toMap() {
    return reminderOn == ReminderOnEnum.note
        ? {
            "title": title,
            "date": date,
            "recurring": recurring,
            "time": time,
            "end_date": endDate,
            "recurring_period": recurringPeriod,
            "note_id": id,
          }
        : {
            "title": title,
            "date": date,
            "recurring": recurring,
            "time": time,
            "end_date": endDate,
            "recurring_period": recurringPeriod,
            "ids": ids,
          };
  }
}
