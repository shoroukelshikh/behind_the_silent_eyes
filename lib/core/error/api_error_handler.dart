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
    final data = response?.data;

    String extractMessage() {
      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String) return message;
        if (message is List && message.isNotEmpty) {
          return message.first.toString();
        }
      }

      if (data is String) {
        return data;
      }

      return 'Server error occurred';
    }

    switch (response?.statusCode) {
      case 401:
        return const UnauthorizedFailure();

      case 404:
        return NotFoundFailure(extractMessage());

      case 422:
        return ValidationFailure(_extractValidationMessage(data));

      default:
        return ServerFailure(extractMessage());
    }
  }
  static String _extractValidationMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];

      if (errors is Map && errors.isNotEmpty) {
        final firstError = errors.values.first;

        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
      }

      final message = data['message'];
      if (message is String) return message;
    }

    return 'Validation error';
  }}