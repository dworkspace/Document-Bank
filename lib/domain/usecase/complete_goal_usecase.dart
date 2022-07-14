import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/todo_goal.dart';
import 'package:document_bank/domain/repository/goal_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class CompleteGoalUseCase extends BaseUseCase<int, List<TodoGoal>> {
  final GoalRepository _goalRepository;

  CompleteGoalUseCase(this._goalRepository);

  @override
  Future<Either<CustomFailure, List<TodoGoal>>> execute(int input) async {
    return await _goalRepository.completeGoal(input);
  }
}
