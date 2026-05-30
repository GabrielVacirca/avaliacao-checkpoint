import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:usedev_uninassau/src/models/product_model.dart';

class ProductService {
  ProductService._();

  static final ProductService instance = ProductService._();

  static const String _productsEndpoint = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProductsList() async {
    final uri = Uri.parse(_productsEndpoint);

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw const ProductServiceException(
          'Falha ao comunicar com o servidor. Tente novamente.',
        );
      }

      final rawData = jsonDecode(response.body);
      if (rawData is! List<dynamic>) {
        throw const ProductServiceException(
          'O catálogo recebeu uma resposta inválida do servidor.',
        );
      }

      return rawData
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on ProductServiceException {
      rethrow;
    } on TimeoutException {
      throw const ProductServiceException(
        'A conexão demorou demais. Tente novamente.',
      );
    } on http.ClientException {
      throw const ProductServiceException(
        'Falha na conexão. Verifique sua internet.',
      );
    } on FormatException {
      throw const ProductServiceException(
        'O catálogo recebeu uma resposta inválida do servidor.',
      );
    } catch (_) {
      throw const ProductServiceException(
        'Não foi possível carregar o catálogo de produtos.',
      );
    }
  }
}

class ProductServiceException implements Exception {
  const ProductServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}
