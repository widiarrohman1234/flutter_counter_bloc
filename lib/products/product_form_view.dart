import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/products/bloc/product_bloc.dart';
import 'package:flutter_counter_bloc/products/models/product_model.dart';


class ProductFormView extends StatefulWidget {

  final ProductModel? product;

  const ProductFormView({
    super.key,
    this.product,
  });

  @override
  State<ProductFormView> createState() =>
      _ProductFormViewState();
}

class _ProductFormViewState
    extends State<ProductFormView> {

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController stockController;

  bool available = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.product?.name ??
          widget.product?.name ?? '',
    );

    descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );

    stockController = TextEditingController(
      text: widget.product?.stock.toString() ?? '0',
    );

    available = widget.product?.available ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? 'Update Product'
              : 'Create Product',
        ),
      ),

      body: BlocConsumer<ProductBloc, ProductState>(

        listener: (context, state) {

          if (state is ProductSuccess) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );

            Navigator.pop(context);
          }

          if (state is ProductFailure) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },

        builder: (context, state) {

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: stockController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                  ),
                ),

                const SizedBox(height: 16),

                SwitchListTile(
                  value: available,
                  title: const Text('Available'),

                  onChanged: (value) {
                    setState(() {
                      available = value;
                    });
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(

                    onPressed: state is ProductLoading
                        ? null
                        : () {

                            // CREATE
                            if (!isEdit) {

                              context.read<ProductBloc>()
                                  .add(

                                CreateProduct(
                                  name:
                                      nameController.text,

                                  description:
                                      descriptionController.text,

                                  stock: int.parse(
                                    stockController.text,
                                  ),

                                  available: available,
                                ),
                              );
                            }

                            // UPDATE
                            else {

                              context.read<ProductBloc>()
                                  .add(

                                UpdateProduct(

                                  documentId:
                                      widget.product!
                                          .documentid,

                                  name:
                                      nameController.text,

                                  description:
                                      descriptionController.text,

                                  stock: int.parse(
                                    stockController.text,
                                  ),

                                  available: available,
                                ),
                              );
                            }
                          },

                    child: state is ProductLoading

                        ? const CircularProgressIndicator()

                        : Text(
                            isEdit
                                ? 'Update Product'
                                : 'Create Product',
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
