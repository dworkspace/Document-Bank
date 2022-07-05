import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/todo_goal.dart';
import 'package:document_bank/domain/repository/goal_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class CreateGoalUseCase extends BaseUseCase<String, List<TodoGoal>> {
  final GoalRepository _goalRepository;

  CreateGoalUseCase(this._goalRepository);

  @override
  Future<Either<CustomFailure, List<TodoGoal>>> execute(String input) async {
    return await _goalRepository.createTodo(input);
  }
}
