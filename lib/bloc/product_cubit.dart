import 'package:bloc/bloc.dart';
import 'package:typesense_flutter/bloc/search_filter_cubit.dart';
import 'package:typesense_flutter/models/product_model.dart';
import 'package:typesense_flutter/repository/typesense_repository.dart';

enum RequestStatus { idle, loading, loaded, error }

class ProductState {
  final RequestStatus status;
  final List<ProductModel> products;
  final String? error;
  final List<String> categories;
  final RequestStatus categoryStatus;

  ProductState({
    required this.status,
    required this.products,
    required this.error,
    required this.categories,
    required this.categoryStatus,
  });

  ProductState copyWith({
    RequestStatus? status,
    List<ProductModel>? products,
    String? error,
    List<String>? categories,
    RequestStatus? categoryStatus,
  }) =>
      ProductState(
        status: status ?? this.status,
        products: products ?? this.products,
        error: error ?? this.error,
        categories: categories ?? this.categories,
        categoryStatus: categoryStatus ?? this.categoryStatus,
      );
}

class ProductCubit extends Cubit<ProductState> {
  final TypesenseRepository _typesenseRepository = TypesenseRepository();
  ProductCubit()
      : super(
          ProductState(
            status: RequestStatus.idle,
            products: [],
            error: '',
            categories: [],
            categoryStatus: RequestStatus.idle,
          ),
        );

  void searchProduct(SearchFilterState filterState) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      final response = await _typesenseRepository.searchProduct(filterState);
      emit(state.copyWith(status: RequestStatus.loaded, products: response));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }

  void getCategories() async {
    emit(state.copyWith(categoryStatus: RequestStatus.loading));
    try {
      final response = await _typesenseRepository.getCategories();
      emit(state.copyWith(
          categoryStatus: RequestStatus.loaded, categories: response));
    } catch (e) {
      emit(state.copyWith(
          categoryStatus: RequestStatus.error, error: e.toString()));
    }
  }
}
