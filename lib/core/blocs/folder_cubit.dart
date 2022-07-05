import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/usecase/get_all_folders_usecase.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  FolderCubit(this._getAllFoldersUseCase) : super(FolderState()) {
    getFolders();
  }

  final GetAllFoldersUseCase _getAllFoldersUseCase;

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
}
