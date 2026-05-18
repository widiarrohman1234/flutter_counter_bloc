import 'package:flutter_counter_bloc/products/models/product_meta.dart';
import 'package:flutter_counter_bloc/products/models/product_model.dart';

class ProductListModel {
  final List<ProductModel> data;
  final ProductMetaModel? meta;

  ProductListModel({
    required this.data,
    this.meta,
  });

  ProductListModel copyWith({
    List<ProductModel>? data,
    ProductMetaModel? meta,
  }) {
    return ProductListModel(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  factory ProductListModel.fromMap(Map<String, dynamic> json) {
    return ProductListModel(
      data: json['data'] != null ? List<ProductModel>.from((json['data'] as List).map((x) => ProductModel.fromMap(Map<String, dynamic>.from(x)))) : [],
      meta: json['meta'] != null ? ProductMetaModel.fromMap(Map<String, dynamic>.from(json['meta'])) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'meta': meta?.toMap(),
    };
  }
}
