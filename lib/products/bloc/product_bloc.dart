import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_counter_bloc/products/models/product_detail.dart';
import 'package:flutter_counter_bloc/products/models/product_model.dart';
import 'package:flutter_counter_bloc/products/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);

    on<FetchProductDetail>(_onFetchProductDetail);

    on<CreateProduct>(_onCreateProduct);

    on<UpdateProduct>(_onUpdateProduct);

    on<DeleteProduct>(_onDeleteProduct);
  }

  // FETCH PRODUCTS
  Future<void> _onFetchProducts(
    FetchProducts event,

    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      final response = await repository.findAll(token: event.token);

      emit(ProductLoaded(products: response.data));
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
  }

  // FETCH DETAIL
  Future<void> _onFetchProductDetail(
    FetchProductDetail event,

    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      final response = await repository.findOne(
        token: event.token,
        documentId: event.documentId,
      );

      emit(ProductDetailLoaded(product_detail: response));
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
  }

  // CREATE
  Future<void> _onCreateProduct(
    CreateProduct event,

    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      await repository.create(
        token: event.token,

        name: event.name,

        description: event.description,

        stock: event.stock,

        available: event.available,
      );

      emit(const ProductSuccess(message: 'Product berhasil dibuat'));

      add(FetchProducts(token: event.token));
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
  }

  // UPDATE
  Future<void> _onUpdateProduct(
    UpdateProduct event,

    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      await repository.update(
        token: event.token,

        documentId: event.documentId,

        name: event.name,

        description: event.description,

        stock: event.stock,

        available: event.available,
      );

      emit(const ProductSuccess(message: 'Product berhasil diupdate'));

      add(FetchProducts(token: event.token));
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
  }

  // DELETE
  Future<void> _onDeleteProduct(
    DeleteProduct event,

    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      await repository.delete(
        token: event.token,

        documentId: event.documentId,
      );

      emit(const ProductSuccess(message: 'Product berhasil dihapus'));

      add(FetchProducts(token: event.token));
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
  }
}
