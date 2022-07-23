import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/model/note_folder.dart';
import 'package:document_bank/domain/usecase/get_all_folders_usecase.dart';
import 'package:document_bank/domain/usecase/get_note_folders_usecase.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  FolderCubit(this._getAllFoldersUseCase, this._getNoteFoldersUseCase)
      : super(FolderState()) {
    getFolders();
    getNoteFolders();
  }

  final GetAllFoldersUseCase _getAllFoldersUseCase;
  final GetNoteFoldersUseCase _getNoteFoldersUseCase;

  getFolders() async {
    emit(state.copyWith(status: FolderStatus.loading));

    // ignore: void_checks
    final response = await _getAllFoldersUseCase.execute(Void);

    response.fold(
      (fail) => emit(state.copyWith(
          status: FolderStatus.failure, errorMessage: fail.message)),
      (data) =>
          emit(state.copyWith(status: FolderStatus.success, folders: data)),
    );
  }

  void getNoteFolders() async {
    emit(state.copyWith(noteFolderStatus: FolderStatus.loading));

    // ignore: void_checks
    final response = await _getNoteFoldersUseCase.execute(Void);

    response.fold(
      (fail) => emit(state.copyWith(
          noteFolderStatus: FolderStatus.failure, errorMessage: fail.message)),
      (data) => emit(state.copyWith(
          noteFolderStatus: FolderStatus.success, noteFolders: data)),
    );
  }
}
