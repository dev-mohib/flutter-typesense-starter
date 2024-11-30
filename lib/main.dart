import 'package:flutter/material.dart';
import 'package:typesense_flutter/bloc/product_cubit.dart';
import 'package:typesense_flutter/bloc/search_filter_cubit.dart';
import 'package:typesense_flutter/repository/typesense_repository.dart';
import 'package:typesense_flutter/search_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter eCommerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider<TypesenseRepository>(
        create: (context) => TypesenseRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductCubit>(
              create: (BuildContext context) => ProductCubit(),
            ),
            BlocProvider<SearchFilterCubit>(
              create: (BuildContext context) => SearchFilterCubit(),
            ),
          ],
          child: SearchScreen(),
        ),
      ),
    );
  }
}
