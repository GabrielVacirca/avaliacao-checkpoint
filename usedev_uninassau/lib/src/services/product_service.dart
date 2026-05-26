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
      final response = await http.get(uri).timeout(
            const Duration(seconds: 15),
          );

      if (response.statusCode != 200) {
        throw Exception(
          'Falha ao comunicar com o servidor. Verifique sua conexão.',
        );
      }

      final List<dynamic> rawData = jsonDecode(response.body) as List<dynamic>;

      return rawData
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (error) {
      if (error is Exception) rethrow;
      throw Exception(
        'Falha na conexão. Não foi possível carregar o catálogo de produtos.',
      );
    }
  }
}
