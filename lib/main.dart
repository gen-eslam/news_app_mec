import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/dio_helper.dart';
import 'package:flutter_application_1/model/repo/news_repo.dart';
import 'package:flutter_application_1/news_cubit/news_cubit.dart';
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
      create: (context) => NewsCubit(newsRepo: NewsRepoImpl())..getNews(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
          ),
          body: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsSuccess) {
                return ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text(state.articles[index].title),
                    );
                  },
                );
              } else if (state is NewsError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
