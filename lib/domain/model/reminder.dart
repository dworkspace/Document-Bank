import 'package:document_bank/data/response/reminder_responses.dart';

class Reminder {
  final int id;
  final String title;
  final String date;
  final int recurring;
  final String recurringPeriod;
  final String endDate;
  final String time;
  final String reminderType;

  Reminder({
    required this.id,
    required this.title,
    required this.date,
    required this.recurring,
    required this.recurringPeriod,
    required this.endDate,
    required this.time,
    required this.reminderType,
  });

  factory Reminder.fromReminderRespnse(ReminderResponse response) {
    return Reminder(
      id: response.id,
      title: response.title,
      date: response.date,
      recurring: response.recurring,
      recurringPeriod: response.recurringPeriod,
      endDate: response.endDate,
      time: response.time,
      reminderType: response.reminderType,
    );
  }
}
