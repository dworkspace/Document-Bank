part of 'add_note_cubit.dart';

extension NotesStateStatusX on StateStatusEnum {
  bool get loading => this == StateStatusEnum.loading;

  bool get failure => this == StateStatusEnum.failure;

  bool get success => this == StateStatusEnum.success;
}

class AddNoteState {
  final StateStatusEnum addNoteStatus;
  final String addNoteErrorMsg;
  final bool isSelectFolder;
  final List<Note> notes;

  AddNoteState({
    this.addNoteStatus = StateStatusEnum.initial,
    this.addNoteErrorMsg = "",
    this.isSelectFolder = true,
    this.notes = const [],
  });

  AddNoteState copyWith({
    StateStatusEnum? addNoteStatus,
    String? addNoteErrorMsg,
    List<Note>? notes,
    bool? isSelectFolder,
  }) {
    return AddNoteState(
      addNoteStatus: addNoteStatus ?? StateStatusEnum.initial,
      notes: notes ?? this.notes,
      isSelectFolder: isSelectFolder ?? true,
      addNoteErrorMsg: addNoteErrorMsg ?? this.addNoteErrorMsg,
    );
  }
}
