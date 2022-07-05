part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final List<Contact> contacts;
  const ContactSuccess({
    required this.contacts,
  });
}

class ContactFailure extends ContactState {
  final String errorMsg;

  const ContactFailure(this.errorMsg);
}
