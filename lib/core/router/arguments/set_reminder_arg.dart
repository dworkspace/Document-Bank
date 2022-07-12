import 'package:document_bank/core/utils/enum.dart';

class SetReminderArg {
  final ReminderOnEnum reminderOn;
  final String? noteId;
  final String? ids;

  SetReminderArg({
    required this.reminderOn,
    this.noteId,
    this.ids,
  }) : assert(reminderOn == ReminderOnEnum.note ? noteId != null : ids != null);
}
