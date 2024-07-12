import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Screen'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        state.products[index].image,
                        fit: BoxFit.fill,
                        height: 200,
                        width: 150,
                      ),
                      const VerticalDivider(
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                    state.products[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                const Icon(
                                  Icons.star,
                                ),
                                Text(
                                  state.products[index].rating.rate.toString(),
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                            Text(
                              state.products[index].description,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              state.products[index].price.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (contex, index) => const Divider(
                color: Colors.transparent,
              ),
              itemCount: state.products.length,
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(state.errorMessage),
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
