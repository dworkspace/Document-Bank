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

enum VerificationStatus { verificationRemaining, profilePending, allCompleted }

extension VerificationStatusTextX on VerificationStatus {
  String getStringValue() {
    switch (this) {
      case VerificationStatus.verificationRemaining:
        return "VERIFICATION_REMAINING";
      case VerificationStatus.profilePending:
        return "PROFILE_PENDING";
      case VerificationStatus.allCompleted:
        return "ALL_COMPLETED";
      default:
        return "";
    }
  }
}
/**
 * VERIFICIATION_REMAINING
    PROFILE_PENDING
    ALL_COMPLETED
 */
