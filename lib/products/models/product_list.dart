import 'package:flutter_counter_bloc/products/models/product_model.dart';

class ProductListModel {
  final List<ProductModel> data;

  ProductListModel({
    required this.data,
  });

  ProductListModel copyWith({
    List<ProductModel>? data,
  }) {
    return ProductListModel(
      data: data ?? this.data,
    );
  }

  factory ProductListModel.fromMap(Map<String, dynamic> json) {
    return ProductListModel(
      data: json['data'] != null ? List<ProductModel>.from((json['data'] as List).map((x) => ProductModel.fromMap(Map<String, dynamic>.from(x)))) : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }
}

