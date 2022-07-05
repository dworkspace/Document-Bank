import 'package:equatable/equatable.dart';

abstract class CustomFailure extends Equatable {
  final String message;

  const CustomFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [];
}

class ServerFailure extends CustomFailure {
  const ServerFailure({required String message}) : super(message: message);
}

class NoInternetFailure extends CustomFailure {
  const NoInternetFailure()
      : super(message: "No internet connection, please check your connection");
}

class CacheFailure extends CustomFailure {
  const CacheFailure({required String message}) : super(message: message);
}

class LocalFailure extends CustomFailure {
  const LocalFailure({required String message}) : super(message: message);
}
