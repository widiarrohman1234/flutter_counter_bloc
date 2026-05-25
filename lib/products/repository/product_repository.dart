import 'dart:convert';

import 'package:flutter_counter_bloc/products/models/product_delete.dart';
import 'package:flutter_counter_bloc/products/models/product_detail.dart';
import 'package:flutter_counter_bloc/products/models/product_list.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final http.Client httpClient;
  ProductRepository({required this.httpClient});
  static const String baseUrl =
      'https://api.ppb.widiarrohman.my.id/api/products';

  // FIND ALL PRODUCTS
  Future<ProductListModel> findAll({required String token}) async {
    final response = await httpClient.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );
    final json = jsonDecode(response.body);
    // ERROR HANDLER
    if (response.statusCode != 200) {
      throw Exception(json['error']?['message'] ?? 'Failed fetch products');
    }

    return ProductListModel.fromMap(json);
  }

  // FIND ONE PRODUCT
  Future<ProductDetailModel> findOne({
    required String token,
    required String documentId,
  }) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/$documentId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(
        json['error']?['message'] ?? 'Failed fetch product detail',
      );
    }

    return ProductDetailModel.fromMap(json);
  }

  // CREATE PRODUCT
  Future<ProductDetailModel> create({
    required String token,
    required String name,
    required bool available,
    required int stock,
    required String description,
    String? imageUrl,
    String? expired,
    String? idCategory,
  }) async {
    final response = await httpClient.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'data': {
          'name': name,
          'available': available,
          'stock': stock,
          'image_url': imageUrl,
          'expired': expired,
          // 'id_category': idCategory,
          'id_category': "83b579b2ea3c4033b6d3bc0891679aec",
          'description': description,
        },
      }),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(json['error']?['message'] ?? 'Create product failed');
    }

    return ProductDetailModel.fromMap(json);
  }

  // UPDATE PRODUCT
  Future<ProductDetailModel> update({
    required String token,
    required String documentId,
    required bool available,
    required int stock,
    required String description,
    required String name,
    String? expired,
    String? idCategory,
  }) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/$documentId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'data': {
          'available': available,
          'stock': stock,
          'expired': expired,
          'description': description,
          'name': name,
          'id_category': idCategory,
        },
      }),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['error']?['message'] ?? 'Update product failed');
    }

    return ProductDetailModel.fromMap(json);
  }

  // DELETE PRODUCT
  Future<ProductDeleteModel> delete({
    required String token,
    required String documentId,
  }) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl/$documentId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['error']?['message'] ?? 'Delete product failed');
    }

    return ProductDeleteModel.fromMap(json);
  }
}
