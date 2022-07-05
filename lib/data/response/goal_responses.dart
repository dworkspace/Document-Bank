import 'package:document_bank/domain/model/todo_goal.dart';

class TodoGoalResponse {
  final int id;
  final String title;
  final int status;

  TodoGoalResponse({
    required this.id,
    required this.title,
    required this.status,
  });

  factory TodoGoalResponse.fromMap(Map<String, dynamic> map) {
    return TodoGoalResponse(
      id: map['id'] ?? 0,
      title: map['title'] ?? "",
      status: map['status'] ?? 0,
    );
  }
}

extension TodoGoalResponseX on TodoGoalResponse {
  TodoGoal toTodoGoal() {
    return TodoGoal(
      title: title,
      id: id,
      status: status,
    );
  }
}
