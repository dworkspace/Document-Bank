import 'package:document_bank/domain/model/memo.dart';

class MemoResponse {
  final int id;
  final String title;
  final String date;
  final String recurringPeriod;

  MemoResponse({
    required this.id,
    required this.title,
    required this.date,
    required this.recurringPeriod,
  });

  factory MemoResponse.fromMap(Map<String, dynamic> map) {
    return MemoResponse(
      id: map['id'] ?? 0,
      title: map['title'] ?? "",
      date: map['date'] ?? "",
      recurringPeriod: map['recurring_period'] ??
          "yearly", //todo: look for enum for recurringPeriod
    );
  }
}

extension MemoResponseX on MemoResponse {
  Memo toMemo() {
    return Memo(
      id: id,
      title: title,
      date: date,
      recurringPeriod: recurringPeriod,
    );
  }
}
