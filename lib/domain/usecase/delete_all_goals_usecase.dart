import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/repository/goal_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class DeleteAllGoalsUseCase extends BaseUseCase<void, String> {
  final GoalRepository _goalRepository;

  DeleteAllGoalsUseCase(this._goalRepository);

  @override
  Future<Either<CustomFailure, String>> execute(void input) async {
    return await _goalRepository.deleteAllGoals();
  }
}
