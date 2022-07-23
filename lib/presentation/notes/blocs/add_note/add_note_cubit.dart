import 'package:bloc/bloc.dart';

import '../../../../core/utils/enum.dart';
import '../../../../data/request/note_requests.dart';
import '../../../../domain/model/note.dart';
import '../../../../domain/usecase/add_note_usecase.dart';
import '../../../../domain/usecase/update_note_usecase.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this._updateNoteUseCase, this._addNoteUseCase)
      : super(AddNoteState());

  void toggleDocumentFolder() async {
    bool isSelectFolder = state.isSelectFolder;
    emit(state.copyWith(isSelectFolder: !isSelectFolder));
  }

  void addNote(AddNoteRequest request) async {
    emit(state.copyWith(addNoteStatus: StateStatusEnum.loading));

    final response = await _addNoteUseCase.execute(request);

    response.fold(
      (fail) => emit(
        state.copyWith(
            addNoteStatus: StateStatusEnum.failure,
            addNoteErrorMsg: fail.message),
      ),
      (data) => emit(
        state.copyWith(
          addNoteStatus: StateStatusEnum.success,
          notes: data,
        ),
      ),
    );
  }

  void updateNote(AddNoteRequest request) async {
    emit(state.copyWith(addNoteStatus: StateStatusEnum.loading));

    final response = await _updateNoteUseCase.execute(request);

    response.fold(
      (fail) => emit(
        state.copyWith(
            addNoteStatus: StateStatusEnum.failure,
            addNoteErrorMsg: fail.message),
      ),
      (data) => emit(
        state.copyWith(
          addNoteStatus: StateStatusEnum.success,
          notes: data,
        ),
      ),
    );
  }

  final AddNoteUseCase _addNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
}
