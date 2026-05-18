part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// INITIAL
final class ProductInitial extends ProductState {}

// LOADING
final class ProductLoading extends ProductState {}

// PRODUCT LIST
final class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

// PRODUCT DETAIL
final class ProductDetailLoaded extends ProductState {
  // final ProductModel product;
  final documentId;

  const ProductDetailLoaded({required this.documentId});

  @override
  List<Object> get props => [documentId];

  get product => null;
}

// SUCCESS
final class ProductSuccess extends ProductState {
  final String message;

  const ProductSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// FAILURE
final class ProductFailure extends ProductState {
  final String message;

  const ProductFailure({required this.message});

  @override
  List<Object> get props => [message];
}
