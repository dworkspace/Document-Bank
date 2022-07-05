part of 'goal_bloc.dart';

@immutable
abstract class GoalEvent {}

class GetAllGoals extends GoalEvent {}

class CreateGoal extends GoalEvent {
  final String title;
  CreateGoal(this.title);
}
