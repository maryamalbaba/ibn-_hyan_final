// ignore: non_constant_identifier_names


import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';

// ignore: non_constant_identifier_names
void HandleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      print("connectio exception");
      throw ErrorModel();
    case DioExceptionType.sendTimeout:
      print("connectio exception");
      throw ErrorModel();
    case DioExceptionType.receiveTimeout:
      print("connectio exception");
    throw ErrorModel();
    case DioExceptionType.badCertificate:
      print("connectio exception");
   throw ErrorModel();
    case DioExceptionType.cancel:
      print("connectio exception");
throw ErrorModel();
    case DioExceptionType.connectionError:
      print("connectio exception");
  throw ErrorModel();
    case DioExceptionType.unknown:
      print("connectio exception");
throw ErrorModel();

    case DioExceptionType.badResponse:
    print("bad response");
print(DioExceptionType.badResponse);
      throw ErrorModel();
  }
}
