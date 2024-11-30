import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typesense_flutter/bloc/product_cubit.dart';
import 'package:typesense_flutter/bloc/search_filter_cubit.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;

  @override
  void initState() {
    super.initState();
    final searchFilterState = context.read<SearchFilterCubit>().state;
    _minPriceController =
        TextEditingController(text: searchFilterState.minPrice.toString());
    _maxPriceController =
        TextEditingController(text: searchFilterState.maxPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFilterCubit, SearchFilterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Filters", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 16),
              Text("Price Range"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Min Price"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        context.read<SearchFilterCubit>().setMinPrice(value);
                      },
                      controller: _minPriceController,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Max Price"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        context.read<SearchFilterCubit>().setMaxPrice(value);
                      },
                      controller: _maxPriceController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // DropDown
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, productCubit) {
                  if (productCubit.categoryStatus == RequestStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  if (productCubit.categoryStatus == RequestStatus.loaded) {
                    return CustomDropdown<String>.multiSelectSearch(
                      hintText: 'Select Categories',
                      items: productCubit.categories,
                      onListChanged: (value) {
                        context.read<SearchFilterCubit>().setCategories(value);
                      },
                      initialItems:
                          context.read<SearchFilterCubit>().state.categories,
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Checkbox(
                    value: state.bestSellingProducts,
                    onChanged: (value) {
                      context
                          .read<SearchFilterCubit>()
                          .setBestSellingProducts(value ?? false);
                    },
                  ),
                  Text("Sort by Best Selling Products")
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text("Apply Filters"),
              ),
            ],
          ),
        );
      },
    );
  }
}
