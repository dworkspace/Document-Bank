import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:document_bank/data/request/document_requests.dart';
import 'package:document_bank/domain/model/add_document.dart';
import 'package:document_bank/domain/usecase/store_documents_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'add_documents_event.dart';

part 'add_documents_state.dart';

class AddDocumentsBloc extends Bloc<AddDocumentsEvent, AddDocumentsState> {
  AddDocumentsBloc(this._imagePicker, this._storeDocumentsUseCase)
      : super(AddDocumentsState()) {
    on<PickedDocFile>(_onPickedDocFile);
    on<ToggleDocumentFolder>(_onToggleDocumentFolder);
    on<DeletePickedFile>(_onDeletePickedFile);
    on<StoreDocuments>(_onStoreDocuments);
  }

  void _onPickedDocFile(
      PickedDocFile event, Emitter<AddDocumentsState> emit) async {
    if (event.pickedFileFromEnum == PickedFileFromEnum.camera) {
      XFile? pickedFile;
      pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        List<File> docFiles = List.from(state.pickedDocFiles);
        final newFile = File(pickedFile.path);
        docFiles.add(newFile);
        emit(state.copyWith(pickedDocFiles: docFiles));
      }
    } else {
      List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
      if(pickedFiles!=null && pickedFiles.isNotEmpty){
        List<File> docFiles = List.from(state.pickedDocFiles);
        for (var xFile in pickedFiles) {
          final newFile = File(xFile.path);
          docFiles.add(newFile);
          emit(state.copyWith(pickedDocFiles: docFiles));
        }
      }
    }
  }

  void _onToggleDocumentFolder(
      ToggleDocumentFolder event, Emitter<AddDocumentsState> emit) async {
    bool isSelectFolder = state.isSelectFolder;
    emit(state.copyWith(isSelectFolder: !isSelectFolder));
  }

  void _onDeletePickedFile(
      DeletePickedFile event, Emitter<AddDocumentsState> emit) async {
    List<File> _docFiles = state.pickedDocFiles;
    _docFiles.removeWhere((file) => file == event.docFile);
    emit(state.copyWith(pickedDocFiles: _docFiles));
  }

  void _onStoreDocuments(
      StoreDocuments event, Emitter<AddDocumentsState> emit) async {
    emit(state.copyWith(status: AddDocumentsStatus.loading));
    List<String> _paths = [];
    for (var file in state.pickedDocFiles) {
      _paths.add(file.path);
    }
    final AddDocumentsRequest request =
        AddDocumentsRequest(folderName: event.folderName, paths: _paths);

    final response = await _storeDocumentsUseCase.execute(request);

    response.fold(
      (fail) => emit(state.copyWith(
          status: AddDocumentsStatus.failure, errorMsg: fail.message)),
      (data) => emit(
          state.copyWith(status: AddDocumentsStatus.success, documents: data)),
    );
  }

  final ImagePicker _imagePicker;
  final StoreDocumentsUseCase _storeDocumentsUseCase;
}
