import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/models/product_list_model.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.posRepository,
  }) : super(const ProductState()) {
    on<GetProducts>(_mapGetProductEventToState);
  }

  final PosRepository posRepository;

  void _mapGetProductEventToState(
      GetProducts event, Emitter<ProductState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      ProductListModel products = await posRepository.getProductsByCategory(event.idCategory);
      switch (products.Code) {
        case 200:
          emit(
            state.copyWith(
              status: ProductStatus.ok,
              products: products,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: ProductStatus.badRequest,
              products: products,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: ProductStatus.unauthorized,
              products: products,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: ProductStatus.forbidden,
              products: products,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: ProductStatus.notFound,
              products: products,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(state.copyWith(status: ProductStatus.error));
    }
  }
}