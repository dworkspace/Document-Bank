part of 'notes_cubit.dart';

extension NotesStateStatusX on StateStatusEnum {
  bool get isLoading => this == StateStatusEnum.loading;

  bool get isFailure => this == StateStatusEnum.failure;

  bool get isSuccess => this == StateStatusEnum.success;
}

class NotesState {
  final StateStatusEnum status;
  final StateStatusEnum addNoteStatus;
  final List<Note> notes;
  final String errorMsg;
  final String addNoteErrorMsg;

  NotesState({
    this.status = StateStatusEnum.initial,
    this.addNoteStatus = StateStatusEnum.initial,
    this.notes = const [],
    this.errorMsg = "",
    this.addNoteErrorMsg = "",
  });

  NotesState copyWith({
    StateStatusEnum? status,
    StateStatusEnum? addNoteStatus,
    List<Note>? notes,
    String? errorMessage,
    String? addNoteErrorMsg,
  }) {
    return NotesState(
      status: status ?? StateStatusEnum.initial,
      addNoteStatus: addNoteStatus ?? StateStatusEnum.initial,
      notes: notes ?? this.notes,
      errorMsg: errorMessage ?? errorMsg,
      addNoteErrorMsg: addNoteErrorMsg ?? this.addNoteErrorMsg,
    );
  }
}
