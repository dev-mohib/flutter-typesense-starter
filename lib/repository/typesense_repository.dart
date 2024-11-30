import 'package:typesense_flutter/bloc/search_filter_cubit.dart';
import 'package:typesense_flutter/models/product_model.dart';
import 'package:typesense_flutter/utils/typesense.dart';

class TypesenseRepository {
  Future<List<ProductModel>> searchProduct(
      SearchFilterState filterState) async {
    final searchParameters = {
      'q': filterState.query,
      'query_by': 'name',
      'sort_by':
          'customerReviewCount:${filterState.bestSellingProducts ? 'asc' : 'desc'}',
    };

    if (filterState.categories.isNotEmpty) {
      searchParameters.addAll({
        'filter_by':
            'salePrice:[${filterState.minPrice}..${filterState.maxPrice}]&&categories:${filterState.categories}',
      });
    } else {
      searchParameters.addAll({
        'filter_by':
            'salePrice:[${filterState.minPrice}..${filterState.maxPrice}]',
      });
    }

    List<ProductModel> products = [];

    final response = await typesenseClient
        .collection('products')
        .documents
        .search(searchParameters);

    for (var element in response['hits']) {
      products.add(ProductModel.fromJson(element['document']));
    }
    return products;
  }

  Future<List<String>> getCategories() async {
    final searchParameters = {
      "q": "*",
      "query_by": "name",
      "facet_by": "categories",
      'max_facet_values': '99999'
    };
    List<String> categories = [];
    final response = await typesenseClient
        .collection('products')
        .documents
        .search(searchParameters);

    for (var element in response['facet_counts']) {
      for (var element in element['counts']) {
        categories.add(element['value']);
      }
    }
    return categories;
  }
}
