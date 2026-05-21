import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/auth/cubit/auth_cubit.dart';
import 'package:flutter_counter_bloc/products/bloc/product_bloc.dart';

import 'product_detail_page.dart';
import 'product_form_page.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();
    final String? token = context.read<AuthCubit>().state.token;
    if (token == null) return;
    context.read<ProductBloc>().add(FetchProducts(token: token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),

      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is ProductFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          // LOADING
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // SUCCESS
          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No Product'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                final String? token = context.read<AuthCubit>().state.token;

                context.read<ProductBloc>().add(FetchProducts(token: token!));
              },

              child: ListView.builder(
                itemCount: state.products.length,

                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    child: ListTile(
                      title: Text(product.name ?? '-'),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const SizedBox(height: 4),

                          Text(
                            product.description ?? '-',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 4),

                          Text('Stock: ${product.stock}'),
                        ],
                      ),

                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'detail',
                            child: Text('Detail'),
                          ),

                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),

                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],

                        onSelected: (value) {
                          // DETAIL
                          if (value == 'detail') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  documentId: product.documentid,
                                ),
                              ),
                            );
                          }

                          // EDIT
                          if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductFormPage(product: product),
                              ),
                            );
                          }

                          // DELETE
                          if (value == 'delete') {
                            showDialog(
                              context: context,

                              builder: (_) {
                                return AlertDialog(
                                  title: const Text('Delete'),

                                  content: const Text('Delete this product?'),

                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        final String? token = context
                                            .read<AuthCubit>()
                                            .state
                                            .token;

                                        context.read<ProductBloc>().add(
                                          DeleteProduct(
                                            documentId: product.documentid,
                                            token: token!,
                                          ),
                                        );
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormPage()),
          );
        },
      ),
    );
  }
}
