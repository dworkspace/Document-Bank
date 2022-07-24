class ReminderResponse {
  final int id;
  final String title;
  final String date;
  final int recurring;
  final String recurringPeriod;
  final String endDate;
  final String time;
  final String reminderType;

  ReminderResponse({
    required this.id,
    required this.title,
    required this.recurringPeriod,
    required this.recurring,
    required this.time,
    required this.endDate,
    required this.date,
    required this.reminderType,
  });

  factory ReminderResponse.fromJson(Map<String, dynamic> json) {
    return ReminderResponse(
      id: json["id"] ?? -1,
      title: json['title'] ?? "",
      recurringPeriod: json["recurring_period"] ?? "none",
      recurring: json["recurring"] ?? -1,
      time: json['time'] ?? "",
      endDate: json["end_date"] ?? "",
      date: json["date"] ?? "",
      reminderType: json["remainder_type"] ?? "N/A",
    );
  }
}
