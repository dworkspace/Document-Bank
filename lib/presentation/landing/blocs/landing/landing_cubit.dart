import 'package:bloc/bloc.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(const LandingState());

  void changeNavIndex(int index) {
    emit(LandingState(navIndex: index));
  }
}
