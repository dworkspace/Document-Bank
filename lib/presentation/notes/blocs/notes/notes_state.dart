part of 'notes_cubit.dart';

extension NotesStateStatusX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isFailure => this == StateStatusEnum.failure;

  bool get isSuccess => this == StateStatusEnum.success;
}

class NotesState {
  final StateStatusEnum status;
  final List<Note> notes;
  final String errorMsg;


  NotesState({
    this.status = StateStatusEnum.initial,

    this.notes = const [],
    this.errorMsg = "",

  });

  NotesState copyWith({
    StateStatusEnum? status,
    List<Note>? notes,
    String? errorMessage,
  }) {
    return NotesState(
      status: status ?? StateStatusEnum.initial,
      notes: notes ?? this.notes,
      errorMsg: errorMessage ?? errorMsg,
    );
  }
}
