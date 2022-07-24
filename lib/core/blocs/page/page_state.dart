part of 'page_cubit.dart';

extension StateStatusEnumX on StateStatusEnum {
  bool get loading => this == StateStatusEnum.loading;

  bool get success => this == StateStatusEnum.success;

  bool get failure => this == StateStatusEnum.failure;
}

class PageState {
  final StateStatusEnum pageStatus;
  final List<PageModel> pages;
  final String errorMessage;

  PageState(
      {this.pageStatus = StateStatusEnum.initial,
      this.pages = const [],
      this.errorMessage = ""});

  PageState copyWith({
    StateStatusEnum? pageStatus,
    List<PageModel>? pages,
    String? errorMessage,
  }) {
    return PageState(
      pageStatus: pageStatus ?? this.pageStatus,
      pages: pages ?? this.pages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
