class CreateMemoRequest {
  final String title;
  final String date;
  final String recurringPeriod;

  CreateMemoRequest({
    required this.title,
    required this.date,
    required this.recurringPeriod,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "date": date,
      "recurring_period": recurringPeriod,
    };
  }
}
