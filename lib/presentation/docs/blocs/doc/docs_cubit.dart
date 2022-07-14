import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:document_bank/domain/model/folder.dart';
import 'package:document_bank/domain/usecase/delete_documents_usecase.dart';
import 'package:document_bank/domain/usecase/get_all_documents_usecase.dart';

part 'docs_state.dart';

class DocsCubit extends Cubit<DocsState> {
  DocsCubit(this._getAllDocumentsUseCase, this._deleteDocumentsUseCase)
      : super(DocsState()) {
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

  ///new
  void setSelectableDocs(List<Document> docs) {
    final List<SelectableDocument> _docList = List<SelectableDocument>.from(
            docs.map((document) => SelectableDocument.fromDocument(document)))
        .toList();
    emit(state.copyWith(
      docs: _docList,
      documents: state.documents,
      folders: state.folders,
      isSelectEnabled: false,
    ));
  }

  void toggleSelectable(bool selectable) {
    if (selectable) {
      emit(state.copyWith(isSelectEnabled: selectable));
    } else {
      final List<SelectableDocument> list = List.from(state.docs);
      for (var value in list) {
        value.isSelected = false;
      }
      emit(state.copyWith(
        isSelectEnabled: selectable,
        docs: list,
        documents: state.documents,
        folders: state.folders,
      ));
    }
  }

  void toggleSelectDoc(SelectableDocument document) {
    List<SelectableDocument> list = List.from(state.docs);
    list[list.indexWhere((element) => element.id == document.id)] =
        SelectableDocument(
      id: document.id,
      photo: document.photo,
      isSelected: !document.isSelected,
    );
    emit(state.copyWith(
      docs: list,
      documents: state.documents,
      folders: state.folders,
    ));
  }

  void deleteDocuments() async {
    emit(state.copyWith(deleteStatus: DocsStateEnum.loading));
    String ids = "";

    List<SelectableDocument> _selectedDocs =
        state.docs.where((element) => element.isSelected == true).toList();

    if (_selectedDocs.length > 1) {
      for (var element in _selectedDocs.take(state.documents.length - 1)) {
        ids = ids + element.id.toString() + ",";
      }
      ids = ids + _selectedDocs[_selectedDocs.length - 1].id.toString();
    } else {
      ids = _selectedDocs[0].id.toString();
    }
    final response = await _deleteDocumentsUseCase.execute(ids);

    response.fold(
      (fail) => emit(state.copyWith(
        deleteStatus: DocsStateEnum.failure,
        deleteErrorMsg: fail.message,
        documents: state.documents,
        folders: state.folders,
      )),
      (data) => emit(state.copyWith(
        deleteStatus: DocsStateEnum.success,
        status: DocsStateEnum.success,
        documents: data,
        folders: data.getFoldersWithDocuments(),
      )),
    );
  }

  final GetAllDocumentsUseCase _getAllDocumentsUseCase;
  final DeleteDocumentsUseCase _deleteDocumentsUseCase;
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
