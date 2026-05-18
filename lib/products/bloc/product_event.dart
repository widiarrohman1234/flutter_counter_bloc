part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// FETCH ALL
final class FetchProducts extends ProductEvent {}

// FETCH DETAIL
final class FetchProductDetail extends ProductEvent {
  final String documentId;

  const FetchProductDetail({required this.documentId});

  @override
  List<Object> get props => [documentId];
}

// CREATE
final class CreateProduct extends ProductEvent {
  final String name;
  final String description;

  final int stock;

  final bool available;

  const CreateProduct({
    required this.name,
    required this.description,

    required this.stock,

    required this.available,
  });

  @override
  List<Object> get props => [name, description, stock, available];
}

// UPDATE
final class UpdateProduct extends ProductEvent {
  final String documentId;

  final String name;
  final String description;

  final int stock;

  final bool available;

  const UpdateProduct({
    required this.documentId,

    required this.name,
    required this.description,

    required this.stock,

    required this.available,
  });

  @override
  List<Object> get props => [documentId, name, description, stock, available];
}

// DELETE
final class DeleteProduct extends ProductEvent {
  final String documentId;

  const DeleteProduct({required this.documentId});

  @override
  List<Object> get props => [documentId];
}
