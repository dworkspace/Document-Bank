enum FieldValidEnum { none, validate, invalidate }

enum StateStatusEnum { initial, loading, failure, success }

enum ReminderRecurringEnum { daily, weekly, monthly, yearly }

extension ReminderRecurringStringX on ReminderRecurringEnum {
  String getStringOfRecurringEnum() {
    switch (this) {
      case ReminderRecurringEnum.daily:
        return "Daily";
      case ReminderRecurringEnum.weekly:
        return "Weekly";
      case ReminderRecurringEnum.monthly:
        return "Monthly";
      case ReminderRecurringEnum.yearly:
        return "Yearly";
      default:
        return "Daily";
    }
  }
}

enum ReminderOnEnum { photo, note }
