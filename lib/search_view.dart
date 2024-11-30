import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typesense_flutter/bloc/product_cubit.dart';
import 'package:typesense_flutter/bloc/search_filter_cubit.dart';
import 'package:typesense_flutter/widgets/search_bottom_sheet.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.status == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Column(
            children: [Text('Products')],
          );
        },
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    final searchFilterCubit = context.read<SearchFilterCubit>();
    searchFilterCubit.setSearchQuery(_searchController.text);
    context.read<ProductCubit>().searchProduct(searchFilterCubit.state);
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getCategories();
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return BlocProvider.value(
            value: BlocProvider.of<SearchFilterCubit>(context),
            child: BlocProvider.value(
                value: BlocProvider.of<ProductCubit>(context),
                child: SearchBottomSheet()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showFilters(context);
                    },
                    icon: Icon(Icons.filter_list),
                    label: Text("Filters"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _performSearch,
                    child: Text("Search"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state.status == RequestStatus.idle) {
                    return const Center(
                      child: Text(
                        "Search Product",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  if (state.status == RequestStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.status == RequestStatus.loaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final result = state.products[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(result.thumbnailImage ??
                                'https://via.placeholder.com/150'),
                            title: Text(result.name),
                            subtitle: Text("Price: \$${result.salePrice}"),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
