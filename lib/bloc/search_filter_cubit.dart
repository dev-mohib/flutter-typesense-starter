import 'package:bloc/bloc.dart';

class SearchFilterState {
  final String query;
  final int minPrice;
  final int maxPrice;
  final List<String> categories;
  final bool bestSellingProducts;

  SearchFilterState(
      {required this.query,
      required this.minPrice,
      required this.maxPrice,
      required this.categories,
      required this.bestSellingProducts});

  SearchFilterState copyWith({
    String? query,
    int? minPrice,
    int? maxPrice,
    List<String>? categories,
    bool? bestSellingProducts,
  }) {
    return SearchFilterState(
      query: query ?? this.query,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      categories: categories ?? this.categories,
      bestSellingProducts: bestSellingProducts ?? this.bestSellingProducts,
    );
  }
}

class SearchFilterCubit extends Cubit<SearchFilterState> {
  SearchFilterCubit()
      : super(
          SearchFilterState(
            query: '',
            minPrice: 1,
            maxPrice: 100000,
            categories: [],
            bestSellingProducts: false,
          ),
        );

  void setSearchQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void setMinPrice(String value) {
    emit(state.copyWith(minPrice: int.parse(value)));
  }

  void setMaxPrice(String value) {
    emit(state.copyWith(maxPrice: int.parse(value)));
  }

  void setBestSellingProducts(bool option) {
    emit(state.copyWith(bestSellingProducts: option));
  }

  void setCategories(List<String> categories) {
    emit(state.copyWith(categories: categories));
  }
}
