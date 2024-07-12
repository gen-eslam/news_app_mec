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
    emit(ProductLoading());
    var res = await productRepo.getProducts();
    res.fold((fail) {
      emit(ProductError(errorMessage: fail.errorMessage));
    }, (sucess) {
      emit(ProductSuccess(products: sucess));
    });
  }
}
