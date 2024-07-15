import 'package:flutter/material.dart';
import 'package:flutter_application_1/product_cubit/product_cubit.dart';
import 'package:flutter_application_1/helper/dio_helper.dart';
import 'package:flutter_application_1/model/news/repo/news_repo.dart';
import 'package:flutter_application_1/model/store/product_repo.dart';
import 'package:flutter_application_1/news_cubit/news_cubit.dart';
import 'package:flutter_application_1/screens/news_app.dart';
import 'package:flutter_application_1/screens/product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(productRepo: ProductRepoImpl())
        ..getAllProduct()
        ..getAllCategory(),
      // create: (context) => NewsCubit(newsRepo: NewsRepoImpl())..getNews(),
      child: const MaterialApp(
        home: ProductScreen(),
      ),
    );
  }
}
