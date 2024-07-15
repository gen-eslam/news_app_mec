import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/model/store/product_model.dart';
import 'package:flutter_application_1/model/store/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepo}) : super(ProductInitial());

  ProductRepo productRepo;

  static ProductCubit get(context) => BlocProvider.of(context);

  void getAllProduct() async {
    emit(ProductCustomState().copyWith(
      state: ProductEnumState.loading,
    ));
    var res = await productRepo.getProducts();
    res.fold((fail) {
      emit(ProductCustomState().copyWith(
          state: ProductEnumState.error, errorMessage: fail.errorMessage));
    }, (sucess) {
      emit(ProductCustomState()
          .copyWith(state: ProductEnumState.success, products: sucess));
    });
  }

  void getSpecificProducts({required String category}) async {
    emit(ProductCustomState().copyWith(
      state: ProductEnumState.loading,
    ));
    var res = await productRepo.getSpecificProducts(category);
    res.fold((fail) {
      emit(ProductCustomState().copyWith(
          state: ProductEnumState.error, errorMessage: fail.errorMessage));
    }, (sucess) {
      emit(ProductCustomState()
          .copyWith(state: ProductEnumState.success, products: sucess));
    });
  }

  void getAllCategory() async {
    emit(CategoryLoading());
    var res = await productRepo.getCategories();
    res.fold((fail) {
      emit(CategoryError(errorMessage: fail.errorMessage));
    }, (sucess) {
      emit(CategorySuccess(categories: sucess));
    });
  }

  void addProduct({required ProductModel product}) async {
    emit(ProductAddState().copyWith(
      state: ProductEnumState.loading,
    ));
    var res = await productRepo.addProduct(product.toJson());
    res.fold((fail) {
      emit(ProductAddState().copyWith(
          state: ProductEnumState.error, errorMessage: fail.errorMessage));
    }, (sucess) {
      emit(ProductAddState()
          .copyWith(state: ProductEnumState.success, products: sucess));
    });
  }
}
