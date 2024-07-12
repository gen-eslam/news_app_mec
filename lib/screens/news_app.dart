import 'package:flutter/material.dart';
import 'package:flutter_application_1/news_cubit/news_cubit.dart';
import 'package:flutter_application_1/screens/web_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsAppScreen extends StatelessWidget {
  const NewsAppScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                NewsCubit.get(context).getNews();
              },
              child: ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CustomWebViewWidget(
                            url: state.articles[index].url,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Text(state.articles[index].title),
                    ),
                  );
                },
              ),
            );
          } else if (state is NewsError) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error),
                  ElevatedButton(
                      onPressed: () {
                        NewsCubit.get(context).getNews();
                      },
                      child: const Text('Retry'))
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
