// ignore_for_file: prefer_initializing_formals

part of 'category_bloc.dart';

enum CategoryStatus {
  initial,
  ok,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  loading,
  error,
  selected,
}

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isOk => this == CategoryStatus.ok;
  bool get isBadRequest => this == CategoryStatus.badRequest;
  bool get isUnauthorized => this == CategoryStatus.unauthorized;
  bool get isForbidden => this == CategoryStatus.forbidden;
  bool get isNotFound => this == CategoryStatus.notFound;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isError => this == CategoryStatus.error;
  bool get isSelected => this == CategoryStatus.selected;
}

class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryStatus.initial,
    CategoryListModel? categories,
    String idSelected = '',
  })  : categories = categories ?? CategoryListModel.empty,
        idSelected = idSelected;

  final CategoryListModel categories;
  final CategoryStatus status;
  final String idSelected;

  @override
  List<Object?> get props => [status, categories, idSelected];

  CategoryState copyWith({
    CategoryListModel? categories,
    CategoryStatus? status,
    String? idSelected,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      idSelected: idSelected ?? this.idSelected,
    );
  }
}
