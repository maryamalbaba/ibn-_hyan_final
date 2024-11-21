// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Error/handle_dio_exception.dart';


import 'package:ibnhyanfinal/core/api/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({
    required this.dio,
  }) {
    dio.options.baseUrl = "http://localhost:8000/api/v1/";
  }
  @override
  Future<Response> delete(String path,
      {bool is_need_data_to_map = false,
      Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Response> get(
    String path, {
    Object? data,
    num? id,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(path,
          options: options, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
    }
    throw UnimplementedError();
  }

  @override
  Future<Response> patch(String path,
      {bool is_need_data_to_map = false,
      Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      Response response = await dio.patch(path,
          options: options, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
    }
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response> post(String path,
      {bool is_need_data_to_map = false,
      Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      Response response = await dio.post(path,
          options: options, data: data, queryParameters: queryParameters);
          print("error bofore if");
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
      throw e;
    }

   
  }
}
