import 'package:bloc/bloc.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/domain/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<PerformRegisterEvent>(_onPerformRegister);
  }

  void _onPerformRegister(
      PerformRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final registerResponse =
        await _registerUseCase.execute(event.registerRequest);
    registerResponse.fold(
      (fail) => emit(RegisterFailure(errorMessage: fail.message)),
      (success) => emit(RegisterSuccess(successMsg: success)),
    );
  }

  final RegisterUseCase _registerUseCase;
}
