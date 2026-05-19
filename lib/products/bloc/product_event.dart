part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// FETCH ALL
final class FetchProducts extends ProductEvent {
  final String token;

  const FetchProducts({required this.token});

  @override
  List<Object> get props => [token];
}

// FETCH DETAIL
final class FetchProductDetail extends ProductEvent {
  final String documentId;
  final String token;

  const FetchProductDetail({required this.documentId, required this.token});

  @override
  List<Object> get props => [documentId, token];
}

// CREATE
final class CreateProduct extends ProductEvent {
  final String name;
  final String description;
  final int stock;
  final bool available;
  final String token;

  const CreateProduct({
    required this.name,
    required this.description,
    required this.stock,
    required this.available,
    required this.token,
  });

  @override
  List<Object> get props => [name, description, stock, available, token];
}

// UPDATE
final class UpdateProduct extends ProductEvent {
  final String documentId;
  final String name;
  final String description;
  final int stock;
  final bool available;
  final String token;

  const UpdateProduct({
    required this.documentId,
    required this.name,
    required this.description,
    required this.stock,
    required this.available,
    required this.token,
  });

  @override
  List<Object> get props => [documentId, name, description, stock, available];
}

// DELETE
final class DeleteProduct extends ProductEvent {
  final String documentId;
  final String token;

  const DeleteProduct({required this.documentId, required this.token});

  @override
  List<Object> get props => [documentId, token];
}
