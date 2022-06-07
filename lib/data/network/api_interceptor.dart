import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  AppInterceptors({
    required this.dio,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // throw ServerException(message: err.message);
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
          case 403:
            throw UnauthorizedException(err.requestOptions, err.response);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 422:
            throw UnprocessableException(err.requestOptions, err.response);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(
                err.requestOptions, err.response!);
          default:
            throw DefaultException(err.requestOptions);
        }
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
      default:
        throw DefaultException(err.requestOptions);
    }

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r, Response response)
      : super(
          requestOptions: r,
          response: response,
        );

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    if (requestOptions.path == "/register-user") {
      final Map<String, dynamic> msgMap = response?.data['errors'];
      String errorMessage = "";
      msgMap.forEach((key, value) {
        final _value = value;
        for (var element in _value) {
          errorMessage = errorMessage + " " + element;
        }
      });
      return errorMessage;
    }
    return response?.data['message'] ?? 'Access denied';
  }
}

class UnprocessableException extends DioError {
  UnprocessableException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    final Map<String, dynamic> msgMap = response?.data['errors'];
    String errorMessage = "";
    msgMap.forEach((key, value) {
      final _value = value;
      for (var element in _value) {
        errorMessage = errorMessage + " " + element;
      }
    });
    return errorMessage;

    // return response?.data['message'] ?? 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class DefaultException extends DioError {
  DefaultException(RequestOptions r) : super(requestOptions: r);
}
