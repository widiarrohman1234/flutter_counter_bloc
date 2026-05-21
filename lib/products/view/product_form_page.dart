import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/products/models/product_model.dart';

import 'product_form_view.dart';

class ProductFormPage extends StatelessWidget {

  final ProductModel? product;

  const ProductFormPage({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {

    return ProductFormView(
      product: product,
    );
  }
}
