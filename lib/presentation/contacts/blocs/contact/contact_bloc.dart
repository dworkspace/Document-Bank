import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/domain/usecase/fetch_contacts_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(this._fetchContactsUseCase) : super(ContactInitial()) {
    on<FetchContacts>(_onFetchContact);
  }

  void _onFetchContact(FetchContacts event, Emitter<ContactState> emit) async {
    emit(ContactLoading());

    // ignore: void_checks
    final response = await _fetchContactsUseCase.execute(Void);
    response.fold(
      (fail) => emit(ContactFailure(fail.message)),
      (data) => emit(ContactSuccess(contacts: data)),
    );
  }

  final FetchContactsUseCase _fetchContactsUseCase;
}
