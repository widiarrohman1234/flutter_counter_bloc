import 'package:flutter/material.dart';

import 'product_detail_view.dart';

class ProductDetailPage extends StatelessWidget {

  final String documentId;

  const ProductDetailPage({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {

    return ProductDetailView(
      documentId: documentId,
    );
  }
}
