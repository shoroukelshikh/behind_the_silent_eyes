import 'package:dio/dio.dart';
import 'failures.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static Failure handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure();

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response);

      default:
        return const ServerFailure('Unexpected error occurred');
    }
  }

  static Failure _handleStatusCode(Response? response) {
    switch (response?.statusCode) {
      case 401:
        return const UnauthorizedFailure();
      case 404:
        return NotFoundFailure(
          response?.data['message'] ?? 'Not found',
        );
      case 422:
        return ValidationFailure(
          _extractValidationMessage(response?.data),
        );
      default:
        return ServerFailure(
          response?.data['message'] ?? 'Server error occurred',
        );
    }
  }

  static String _extractValidationMessage(dynamic data) {
    if (data == null) return 'Validation error';
    // Laravel بيرجع الـ validation errors جوه errors object
    // { "errors": { "email": ["required"] } }
    final errors = data['errors'];
    if (errors is Map) {
      final firstKey = errors.keys.first;
      final firstError = errors[firstKey];
      if (firstError is List && firstError.isNotEmpty) {
        return firstError.first.toString();
      }
    }
    return data['message'] ?? 'Validation error';
  }
}