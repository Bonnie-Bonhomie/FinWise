import "package:dio/dio.dart";

abstract class DataState<T> {
  final T? data;
  final DioException? exception;

  const DataState({this.data, this.exception});

  /// A helper getter to extract a readable message
  String? get message {
    if (exception == null) return null;

    // Prefer DioException.message if available, otherwise use error.toString()
    return exception?.message ?? exception?.error?.toString();
  }
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException exception) : super(exception: exception);
}
