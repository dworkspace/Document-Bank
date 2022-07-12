import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/usecase/get_all_documents_usecase.dart';

part 'docs_state.dart';

class DocsCubit extends Cubit<DocsState> {
  DocsCubit(this._getAllDocumentsUseCase) : super(DocsState()) {
    getAllDocuments();
  }

  void getAllDocuments() async {
    emit(state.copyWith(status: DocsStateEnum.loading));

    final response = await _getAllDocumentsUseCase.execute(Void);

    response.fold(
      (fail) => emit(state.copyWith(
          status: DocsStateEnum.failure, errorMessage: fail.message)),
      (data) => emit(
        state.copyWith(
          status: DocsStateEnum.success,
          documents: data,
          folders: data.getFoldersWithDocuments(),
        ),
      ),
    );
  }

  final GetAllDocumentsUseCase _getAllDocumentsUseCase;
}

extension DocumentsListX on List<Document> {
  List<Folder> getFoldersWithDocuments() {
    List<Folder> _folders = [];
    List<String> _folderNames = [];
    for (var document in this) {
      _folderNames.add(document.folder);
    }

    for (var folderName in _folderNames.toSet()) {
      List<Document> docs = [];
      for (var doc in this) {
        if (folderName == doc.folder) {
          docs.add(doc);
        }
      }
      final Folder folder = Folder(title: folderName, documents: docs);
      _folders.add(folder);
    }
    print(_folders.length);
    return _folders;
  }
}
