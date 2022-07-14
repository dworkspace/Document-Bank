import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/todo_goal.dart';

abstract class GoalRepository {
  Future<Either<CustomFailure, List<TodoGoal>>> createTodo(String title);

  Future<Either<CustomFailure, String>> deleteAllGoals();

  Future<Either<CustomFailure, List<TodoGoal>>> getTodoGoals();

  Future<Either<CustomFailure, List<TodoGoal>>> completeGoal(int goalId);
}
