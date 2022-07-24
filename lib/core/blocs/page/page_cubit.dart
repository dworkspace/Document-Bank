import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/domain/model/page.dart';
import 'package:document_bank/domain/usecase/get_pages_usecase.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit(this._getPagesUseCase) : super(PageState()) {
    getPages();
  }

  void getPages() async {
    emit(state.copyWith(pageStatus: StateStatusEnum.loading));

    final response = await _getPagesUseCase.execute(Void);

    response.fold(
      (fail) => emit(state.copyWith(
          pageStatus: StateStatusEnum.failure, errorMessage: fail.message)),
      (data) => emit(
          state.copyWith(pageStatus: StateStatusEnum.success, pages: data)),
    );
  }

  final GetPagesUseCase _getPagesUseCase;
}
