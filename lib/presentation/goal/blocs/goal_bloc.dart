import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:document_bank/domain/model/todo_goal.dart';
import 'package:document_bank/domain/usecase/create_goal_usecase.dart';
import 'package:meta/meta.dart';
import '../../../domain/usecase/get_todo_goals_usecase.dart';

part 'goal_event.dart';

part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc(this._todoGoalsUseCase, this._createGoalUseCase)
      : super(GoalState()) {
    on<GetAllGoals>(_onGetAllGoals);
    on<CreateGoal>(_onCreateGoal);
  }

  void _onGetAllGoals(GetAllGoals event, Emitter<GoalState> emit) async {
    emit(state.copyWith(status: GoalStateEnum.loading));
    // ignore: void_checks
    final response = await _todoGoalsUseCase.execute(Void);

    response.fold(
      (fail) => emit(
        state.copyWith(
          status: GoalStateEnum.failure,
          errorMsg: fail.message,
        ),
      ),
      (data) =>
          emit(state.copyWith(status: GoalStateEnum.success, goalList: data)),
    );
  }

  void _onCreateGoal(CreateGoal event, Emitter<GoalState> emit) async {
    emit(state.copyWith(
      createStatus: GoalStateEnum.loading,
      status: GoalStateEnum.success,
    ));
    // ignore: void_checks
    final response = await _createGoalUseCase.execute(event.title);

    response.fold(
      (fail) => emit(state.copyWith(
          createStatus: GoalStateEnum.failure, errorMsg: fail.message)),
      (data) => emit(state.copyWith(
          createStatus: GoalStateEnum.success,
          status: GoalStateEnum.success,
          goalList: data)),
    );
  }

  final GetTodoGoalsUseCase _todoGoalsUseCase;
  final CreateGoalUseCase _createGoalUseCase;
}