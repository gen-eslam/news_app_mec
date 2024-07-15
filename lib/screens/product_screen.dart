import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/store/product_model.dart';
import 'package:flutter_application_1/product_cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Screen'),
      ),
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductAddState) {
            if (state.state == ProductEnumState.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Product Added'),
                  backgroundColor: Colors.green,
                ),
              );
              ProductCubit.get(context).getAllProduct();
            }
          }
        },
        child: Column(
          children: [
            BlocBuilder<ProductCubit, ProductState>(
              buildWhen: (previous, current) {
                return current is CategorySuccess ||
                    current is CategoryError ||
                    current is CategoryLoading;
              },
              builder: (context, state) {
                if (state is CategorySuccess) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.categories
                          .map(
                            (e) => ElevatedButton(
                              onPressed: () {
                                ProductCubit.get(context)
                                    .getSpecificProducts(category: e);
                              },
                              child: Text(e),
                            ),
                          )
                          .toList(),
                    ),
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
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) {
                  return current is ProductCustomState;
                },
                builder: (context, state) {
                  if (state is ProductCustomState) {
                    switch (state.state) {
                      case ProductEnumState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ProductEnumState.success:
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
                                    state.products[index].image!,
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 150,
                                  ),
                                  const VerticalDivider(
                                    color: Colors.transparent,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                state.products[index].title!,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.star,
                                            ),
                                            Text(
                                              state.products[index].rating!.rate
                                                  .toString(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          state.products[index].description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          state.products[index].price
                                              .toString(),
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

                      case ProductEnumState.error:
                        return Center(
                          child: Text(state.errorMessage),
                        );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProductCubit.get(context).addProduct(
            product: ProductModel(
                description: "faresssss",
                image:
                    "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                price: 100,
                title: "cat"),
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
