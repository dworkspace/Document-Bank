import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/todo_goal.dart';
import 'package:document_bank/domain/repository/goal_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetTodoGoalsUseCase extends BaseUseCase<void, List<TodoGoal>> {
  final GoalRepository _goalRepository;

  GetTodoGoalsUseCase(this._goalRepository);

  @override
  Future<Either<CustomFailure, List<TodoGoal>>> execute(void input) async {
    return await _goalRepository.getTodoGoals();
  }
}
