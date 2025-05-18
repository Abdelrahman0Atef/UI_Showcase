import 'package:dio/dio.dart';

class RestApiServices {
  static final RestApiServices _instance = RestApiServices._internal();
  final Dio dio = Dio();

  factory RestApiServices() => _instance;

  RestApiServices._internal() {
    dio.options.baseUrl = 'https://fakestoreapi.com/products';
    dio.options.connectTimeout = const Duration(seconds: 2);
    dio.options.receiveTimeout = const Duration(seconds: 2);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onResponse: (response, handler) => handler.next(response),
      onError: (DioError e, handler) => handler.next(e),
    ));

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<dynamic> get(String endpoint) async {
    final response = await dio.get(endpoint);
    return response.data;
  }
}
