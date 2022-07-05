part of 'goal_bloc.dart';

class GoalState {
  final GoalStateEnum status;
  final GoalStateEnum createStatus;
  final List<TodoGoal>? goalList;
  final String? errorMsg;

  GoalState({
    this.status = GoalStateEnum.initial,
    this.createStatus = GoalStateEnum.initial,
    this.goalList,
    this.errorMsg,
  });

  GoalState copyWith({
    GoalStateEnum? status,
    GoalStateEnum? createStatus,
    List<TodoGoal>? goalList,
    String? errorMsg,
  }) {
    return GoalState(
      status: status ?? GoalStateEnum.initial,
      createStatus: createStatus ?? GoalStateEnum.initial,
      goalList: goalList ?? this.goalList,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

enum GoalStateEnum { initial, loading, success, failure }

extension GoalStateEnumX on GoalStateEnum {
  bool get isLoading => this == GoalStateEnum.loading;

  bool get isSuccess => this == GoalStateEnum.success;

  bool get isFailure => this == GoalStateEnum.failure;
}
