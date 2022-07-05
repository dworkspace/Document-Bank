part of 'add_documents_bloc.dart';

abstract class AddDocumentsEvent extends Equatable {
  const AddDocumentsEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PickedDocFile extends AddDocumentsEvent {
  final PickedFileFromEnum pickedFileFromEnum;

  const PickedDocFile({required this.pickedFileFromEnum});
}

class DeletePickedFile extends AddDocumentsEvent {
  final File docFile;

  const DeletePickedFile({required this.docFile});
}

class StoreDocuments extends AddDocumentsEvent {
  final String folderName;

  const StoreDocuments({required this.folderName});
}

class ToggleDocumentFolder extends AddDocumentsEvent {}

enum PickedFileFromEnum { camera, gallery }
