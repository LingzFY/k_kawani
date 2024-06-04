import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/models/category_list_model.dart';
import 'package:k_kawani/data/models/category_model.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.posRepository,
  }) : super(const CategoryState()) {
    on<GetCategories>(_mapGetCategoryEventToState);
    on<SelectCategory>(_mapSelectCategoryEventToState);
  }

  final PosRepository posRepository;

  void _mapGetCategoryEventToState(
      GetCategories event, Emitter<CategoryState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: CategoryStatus.loading));
      CategoryListModel categories = await posRepository.getCategories();
      categories.Items.insert(0, CategoryModel.allCategory);
      switch (categories.Code) {
        case 200:
          emit(
            state.copyWith(
              status: CategoryStatus.ok,
              categories: categories,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: CategoryStatus.ok,
              categories: categories,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: CategoryStatus.ok,
              categories: categories,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: CategoryStatus.ok,
              categories: categories,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: CategoryStatus.ok,
              categories: categories,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapSelectCategoryEventToState(
      SelectCategory event, Emitter<CategoryState> emit) async {
    emit(
      state.copyWith(
        status: CategoryStatus.selected,
        idSelected: event.idSelected,
      ),
    );
  }
}
