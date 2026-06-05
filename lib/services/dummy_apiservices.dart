import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopsphere/models/products.dart';
import 'package:shopsphere/services/api_services.dart';

class DummyApiServices {
  Future<List<Products>> getAllProducts() async {
    return await _fetchProducts(ApiServices.products);
  }

  Future<List<Products>> _fetchProducts(String endPoints) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiServices.baseUrl}$endPoints"),
      );

      if (response.statusCode == 200) {
        return compute(parseProducts, response.body);
      } else {
        debugPrint(
          "Fetch Products Failed : ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint("Fetch Products Error : $e");
    }

    throw Exception("Failed after retry");
  }

  Future<List<Products>> fetchProductByCategory(
      String endpoints,
      ) async {
    debugPrint("Fetching category: $endpoints");


    try {

      final response = await http.get(
        Uri.parse(
          "${ApiServices.baseUrl}"
              "${ApiServices.products}/category/"
              "${Uri.encodeComponent(endpoints)}",
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
        json.decode(response.body);

        final List<dynamic> productsData =
        jsonData['products'];

        final List<Products> products = productsData
            .map((json) => Products.fromJson(json))
            .toList();

        return products;
      }

      debugPrint(
        "Category Fetch Failed : ${response.statusCode}",
      );
    } catch (e) {
      debugPrint(
        "Error fetching products by category : $e",
      );
    }

    throw Exception('Failed after retry');
  }

  Future<List<Products>> searchResult(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiServices.baseUrl}'
              '${ApiServices.products}/search?q=$query',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
        json.decode(response.body);

        final List<dynamic> productData =
        data['products'];

        final List<Products> products = productData
            .map((json) => Products.fromJson(json))
            .toList();

        return products;
      } else {
        debugPrint(
          "Search Failed : ${response.statusCode}",
        );

        throw Exception("Failed to Load Products");
      }
    } catch (e) {
      debugPrint("Search Error : $e");

      rethrow;
    }
  }
}

List<Products> parseProducts(String responseBody) {
  final Map<String, dynamic> jsonData =
  jsonDecode(responseBody);

  final List<dynamic> productsData =
  jsonData['products'];

  return productsData
      .map((json) => Products.fromJson(json))
      .toList();
}