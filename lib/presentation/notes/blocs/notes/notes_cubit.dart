import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/domain/model/note.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/domain/usecase/add_note_usecase.dart';
import 'package:document_bank/domain/usecase/get_all_notes_usecase.dart';
import 'package:document_bank/domain/usecase/update_note_usecase.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(
    this._getAllNotesUseCase,
  ) : super(NotesState());



  void getFolderNotes(NoteFolder folder) async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    final response = await _getAllNotesUseCase.execute(folder);

    response.fold(
      (fail) => emit(state.copyWith(
          status: StateStatusEnum.failure, errorMessage: fail.message)),
      (data) =>
          emit(state.copyWith(status: StateStatusEnum.success, notes: data)),
    );
  }



  final GetAllNotesUseCase _getAllNotesUseCase;

}
