import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestApiServices {
  static final RestApiServices _instance = RestApiServices._internal();
  final Dio dio = Dio();

  factory RestApiServices() => _instance;

  RestApiServices._internal() {
    dio.options.baseUrl = dotenv.env['FAKE_BASE_URL'] as String;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException e, handler) => handler.next(e),
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<dynamic> get(String? endpoint) async {
    final response = await dio.get(endpoint!);
    return response.data;
  }

  Future<dynamic> getWithCustomAuth({
    required String baseUrl,
    required String endpoint,
    required String token,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      '$baseUrl$endpoint',
      queryParameters: queryParameters,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }
}
