import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/auth/cubit/auth_cubit.dart';
import 'package:flutter_counter_bloc/products/bloc/product_bloc.dart';

class ProductDetailView extends StatefulWidget {
  final String documentId;

  const ProductDetailView({super.key, required this.documentId});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
    final String? token = context.read<AuthCubit>().state.token;
    if (token == null) return;
    context.read<ProductBloc>().add(
      FetchProductDetail(documentId: widget.documentId, token: token),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailLoaded) {
            final product = state.product_detail;

            return Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    product.data!.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 16),

                  Text(product.data!.description ?? '-'),

                  const SizedBox(height: 16),

                  Text('Stock: ${product.data!.stock}'),

                  const SizedBox(height: 8),

                  Text(product.data!.available ? 'Available' : 'Unavailable'),
                ],
              ),
            );
          }

          if (state is ProductFailure) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
