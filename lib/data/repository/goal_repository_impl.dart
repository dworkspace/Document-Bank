import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/response/goal_responses.dart';
import 'package:document_bank/domain/model/todo_goal.dart';
import 'package:document_bank/domain/repository/goal_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class GoalRepositoryImpl extends GoalRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  GoalRepositoryImpl(this._networkInfo, this._remoteSource);

  @override
  Future<Either<CustomFailure, List<TodoGoal>>> createTodo(String title) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<TodoGoalResponse> response =
            await _remoteSource.createTodoGoal(title);
        final List<TodoGoal> goals =
            List<TodoGoal>.from(response.map((e) => e.toTodoGoal())).toList();
        return Right(goals);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<TodoGoal>>> getTodoGoals() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<TodoGoalResponse> response =
            await _remoteSource.getTodoGoals();
        final List<TodoGoal> goals =
            List<TodoGoal>.from(response.map((e) => e.toTodoGoal())).toList();
        return Right(goals);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, String>> deleteAllGoals() async {
    if (await _networkInfo.isConnected()) {
      try {
        final String response = await _remoteSource.deleteAllGoals();

        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<TodoGoal>>> completeGoal(int goalId) async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<TodoGoalResponse> response =
            await _remoteSource.completeGoal(goalId);
        final List<TodoGoal> goals =
            List<TodoGoal>.from(response.map((e) => e.toTodoGoal())).toList();
        return Right(goals);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
