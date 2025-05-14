import 'package:dio/dio.dart';

class RestApiServices {
  static final RestApiServices _instance = RestApiServices._internal();
  final Dio dio = Dio();
  final String baseUrl = 'https://fakestoreapi.com/products';

  factory RestApiServices() => _instance;

  RestApiServices._internal();

  Future<dynamic> get(String endpoint) async {
      final response = await dio.get(endpoint);
      return response.data;
  }
}
