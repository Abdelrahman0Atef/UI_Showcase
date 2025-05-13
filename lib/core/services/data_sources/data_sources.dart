import 'package:dio/dio.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';

class DataSources {
  final Dio dio;
  final String baseUrl= 'https://fakestoreapi.com/products';
  DataSources(this.dio);

  Future <List<ProModel>> getAllProduct() async {
    try {
      final Response response = await dio.get(baseUrl);
      final List data = response.data;
      return data.map((e)=>ProModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final String eMessage = e.response?.data['error']['message'] ?? 'Error Try Again Later';
      throw Exception(eMessage);
    }catch (e){
      throw Exception('Error $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final Response response = await dio.get('$baseUrl/categories');
      return List<String>.from(response.data);
    } on DioException catch (e) {
      final String eMessage = e.response?.data['error']['message'] ?? 'Error Try Again Later';
      throw Exception(eMessage);
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  Future<List<ProModel>> getProductsByCategory(String category) async {
    try {
      final Response response = await dio.get('$baseUrl/category/$category');
      final List data = response.data;
      return data.map((e) => ProModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final String eMessage = e.response?.data['error']['message'] ?? 'Error Try Again Later';
      throw Exception(eMessage);
    } catch (e) {
      try {
        final allProducts = await getAllProduct();
        return allProducts.where((product) => product.category?.toLowerCase() == category.toLowerCase()).toList();
      } catch (innerE) {
        throw Exception('Error filtering products by category: $innerE');
      }
    }
  }

}
